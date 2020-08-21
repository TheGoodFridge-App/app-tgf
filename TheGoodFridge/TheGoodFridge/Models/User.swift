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
    
    init() {
        self.firstName = Auth.auth().currentUser?.displayName
        self.email = Auth.auth().currentUser?.email
    }
    
    weak var delegate: UserDelegate?
    
    func getUserData() -> UserData? {
        if let first = firstName, let last = lastName {
            return UserData(first_name: first, last_name: last)
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
                            self.delegate?.didGetUserData(userData: user)
                        }
                        
                    }
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
