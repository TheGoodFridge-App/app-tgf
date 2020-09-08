//
//  UserInfo.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation
import Firebase
import Alamofire
import FirebaseAuth

protocol UserDelegate: class {
    func didGetUserData(userData: UserData)
}

class User {
    var firstName: String?
    var lastName: String?
    var email: String?
    var imageURL: String?
    var storage: Storage
    
    init() {
        self.firstName = Auth.auth().currentUser?.displayName
        self.email = Auth.auth().currentUser?.email
        self.storage = Storage.storage()
    }
    
    var userDelegate: UserDelegate?
    var profileDelegate: ProfileDelegate?
    
    func getUserData() -> UserData? {
        if let first = firstName, let last = lastName {
            var userData = UserData(first_name: first, last_name: last)
            if let url = imageURL {
                userData.image_url = url
            }
            
            return userData
        }
        
        fetchUserData()
        return nil
    }
    
    func fetchUserData() {
        if let email = self.email {
            let urlString = "\(K.serverURL)/api/data"
            
            let parameters: [String: String] = [
                "email": email,
                "secret": K.secretKey
            ]
            
            AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
                .response { response in
                    debugPrint("received user data")
                    debugPrint(response)
                    if let responseData = response.data {
                        let userData = self.parseJSON(data: responseData)
                        if let user = userData {
                            self.firstName = user.first_name
                            self.lastName = user.last_name
                            self.imageURL = user.image_url
                            self.userDelegate?.didGetUserData(userData: user)
                        }
                        
                    }
            }
        }
    }
    
    func setImage(to image: UIImage) {
        guard let email = email else {
            debugPrint("Could not find email while uploading image")
            return
        }
        // Storage setup
        let storageRef = storage.reference()
        let profileRef = storageRef.child("profile/user-\(email)")
        let metadata = StorageMetadata()
        metadata.customMetadata = [
            "email": email
        ]
        
        let imageData = image.jpegData(compressionQuality: 1)
        if let data = imageData {
            profileRef.putData(data, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                    debugPrint("Error: could not retrieve image metadata")
                    return
                }
                
                let size = metadata.size
                debugPrint("Image size: \(size)")
                profileRef.downloadURL { (url, error) in
                    self.imageURL = url?.absoluteString
                    debugPrint("Obtained image URL")
                    
                    // Update user info here
                    self.updateImage(to: self.imageURL)
                }
            }
        }
    }
    
    func getProfilePicture() {
        guard let downloadURL = imageURL else { return }
        
        let profileReference = storage.reference(forURL: downloadURL)
        profileReference.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                debugPrint("Error getting data from download URL: \(error)")
                return
            }
            
            if let image = UIImage(data: data!) {
                self.profileDelegate?.didGetProfilePicture(image: image)
            } else {
                debugPrint("Could not turn profile image data into image")
            }
        }
    }
    
    private func updateImage(to imageURL: String?) {
        if let url = imageURL {
            guard let email = self.email else { return }
            
            let urlString = "\(K.serverURL)/api/image/update"
            let parameters = [
                "email": email,
                "image_url": url,
                "secret": K.secretKey
            ]
            
            AF.request(urlString, method: .put, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
                .validate()
                .response() { response in
                    debugPrint(response)
            }
        }
    }
    
    private func parseJSON(data: Data) -> UserData? {
        do {
            let decoder = JSONDecoder()
            let userData =  try decoder.decode(UserData.self, from: data)
            return userData
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
}
