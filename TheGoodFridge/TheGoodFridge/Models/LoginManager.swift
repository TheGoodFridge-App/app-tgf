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
    
    let urlString = "localhost:3000"
    static var googleCredential: AuthCredential?
    
    func login(email: String, password: String) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request("\(urlString)/api/login", parameters: parameters)
            .validate()
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
}
