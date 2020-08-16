//
//  LoginManager.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 4/19/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import FirebaseAuth

struct LoginManager {
    
    let urlString = "\(K.serverURL)"
    static var googleCredential: AuthCredential?
    
    func login(email: String, password: String) {
        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "secret": K.secretKey
        ]
        
        AF.request("\(urlString)/api/login", parameters: parameters)
            .validate()
            .responseJSON { response in
                debugPrint("logged in")
        }
    }
    
}
