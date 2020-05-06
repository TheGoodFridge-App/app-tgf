//
//  UserInfo.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation

class User {
    static let shared = User()
    
    private var firstName: String?
    private var lastName: String?
    private var email: String?
    
    func getFirstName() -> String? {
        if firstName == nil {
            // MARK: - TODO: Get name from server
        }
        
        return firstName
    }
    
    func getLastName() -> String? {
        if lastName == nil {
            // MARK: - TODO: Get name from server
        }
        
        return lastName
    }
    
    func getEmail() -> String? {
        if email == nil {
            // MARK: - TODO: Get name from server
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
}
