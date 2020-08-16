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
    func didGetUserData()
}

class User {
    static let shared = User()
    
    private var firstName: String?
    private var lastName: String?
    private var email: String?
    private var userData: UserData?
    weak var delegate: UserDelegate?
    
    func updateData() {
        if let userData = userData {
            firstName = userData.first_name
            lastName = userData.last_name
            email = Auth.auth().currentUser?.email
        }
    }
    
    func getFirstName() -> String? {
        if firstName == nil {
            fetchData()
            return nil
        }
        
        return firstName
    }
    
    func getLastName() -> String? {
        if lastName == nil {
            fetchData()
            return nil
        } else {
            delegate?.didGetUserData()
        }
        
        return lastName
    }
    
    func getEmail() -> String? {
        if email == nil {
            email = Auth.auth().currentUser?.email
        }
        
        return email
    }
    
    func setFirstName(to firstName: String?) {
        self.firstName = firstName
    }
    
    func setLastName(to lastName: String?) {
        self.lastName = lastName
    }
    
    func setEmail(to email: String?) {
        self.email = email
    }
    
    func fetchData() {
        if let email = getEmail() {
            let urlString = "\(K.serverURL)/api/data"
            
            let parameters: [String: String] = [
                "email": email,
                "secret": K.secretKey
            ]
            
            AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
                .response { response in
                    debugPrint("received email")
                    if let responseData = response.data {
                        self.userData = self.parseJSON(data: responseData)
                        self.updateData()
                        self.delegate?.didGetUserData()
                    }
            }
        }
    }
    
    private func parseJSON(data: Data) -> UserData? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(UserData.self, from: data)
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
}
