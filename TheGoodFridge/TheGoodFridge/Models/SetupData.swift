//
//  SetupData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation
import Alamofire

struct SetupData {
    var environment = false
    var human = false
    var animal = false
    
    var environmentIssues = [String]()
    var humanIssues = [String]()
    var animalIssues = [String]()
    
    mutating func setEnvironment() {
        environment = true
    }
    
    mutating func setHuman() {
        human = true
    }
    
    mutating func setAnimal() {
        animal = true
    }
    
    mutating func unsetEnvironment() {
        environment = false
    }
    
    mutating func unsetHuman() {
        human = false
    }
    
    mutating func unsetAnimal() {
        animal = false
    }
    
    mutating func setIssues(type: ValueType, issues: [Int]) {
        if type == .environment {
            environmentIssues = IssueData.getSelected(type: type, issues: issues)
        } else if type == .animal {
            animalIssues = IssueData.getSelected(type: type, issues: issues)
        } else {
            humanIssues = IssueData.getSelected(type: type, issues: issues)
        }
        
        print(environmentIssues)
        print(animalIssues)
    }
    
    func postSetupData() {
        guard let email = User.shared.getEmail(),
            let firstName = User.shared.getFirstName(),
            let lastName = User.shared.getLastName()
        else { return debugPrint("Can't find email") }
        
        let parameters: [String: [String]] = [
            "email": [email],
            "first_name": [firstName],
            "last_name": [lastName],
            "environment": [(environment ? "true" : "false")],
            "animal": [(animal ? "true" : "false")],
            "human": [(human ? "true" : "false")],
            "environment_issues": environmentIssues,
            "animal_issues": animalIssues,
            "human_issues": humanIssues
        ]
        
        let urlString = "\(K.serverURL)/api/values"
        print(urlString)
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .response { response in
                debugPrint(response)
        }
    }
    
}
