//
//  SetupData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation
import Alamofire

struct ChallengeData: Codable {
    var challenges: [String]
}

struct SetupData {
    var environment = false
    var human = false
    var animal = false
    
    var environmentIssues = [String]()
    var humanIssues = [String]()
    var animalIssues = [String]()
    
    var delegate: SetupDelegate?
    
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
            (environmentIssues, _) = IssueData.getSelected(type: type, issues: issues)
        } else if type == .animal {
            (animalIssues, _) = IssueData.getSelected(type: type, issues: issues)
        } else {
            (humanIssues, _) = IssueData.getSelected(type: type, issues: issues)
        }
        
    }
    
    func postValuesIssues() {
        guard let email = User.shared.getEmail(),
            let firstName = User.shared.getFirstName(),
            let lastName = User.shared.getLastName()
        else { return debugPrint("Can't find email") }
        
        var parameters: [String: [String]] = [
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
        
        var urlString = "\(K.serverURL)/api/values"
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .response { response in
                if let e = response.error {
                    debugPrint("Error: \(e)")
                    return
                }
                debugPrint(response)
        }
        
        // Getting challenges
        let issues = [environmentIssues, animalIssues, humanIssues]
        urlString = "\(K.serverURL)/challenges/from_issues"
        
        let group = DispatchGroup()
        
        var challengesDict = [String: [String]]()
        
        for (i, issue) in issues.enumerated() {
            parameters = [
                "issues": issue
            ]
            
            group.enter()
            AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
                .response { response in
                    if let e = response.error {
                        debugPrint("Error: \(e)")
                        return
                    }
                    debugPrint(response)
                    if let data = response.data, let challenges = self.parseChallengeJSON(data: data) {
                        //self.delegate?.receivedChallenges(challenges: challenges)
                        if i == 0 {
                            challengesDict["environment"] = challenges
                        } else if i == 1 {
                            challengesDict["animal"] = challenges
                        } else {
                            challengesDict["human"] = challenges
                        }
                    }
                    group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print(challengesDict)
            self.delegate?.receivedChallenges(challenges: challengesDict)
        }
    }
    
    private func parseChallengeJSON(data: Data) -> [String]? {
        do {
            print(data)
            let decoder = JSONDecoder()
            let challengeData = try decoder.decode(ChallengeData.self, from: data)
            print(challengeData)
            return challengeData.challenges
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
}
