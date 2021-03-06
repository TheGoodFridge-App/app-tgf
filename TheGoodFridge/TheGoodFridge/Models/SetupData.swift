//
//  SetupData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Firebase
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
    
    var challenges = [String: [String]]()
    
    var delegate: SetupDelegate?
    
    var lastName: String?
    var firstName: String?
    var email: String?
    
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
    
    mutating func setChallenges(_ challenges: [String: [String]]) {
        self.challenges = challenges
    }
    
    func getChallenges() {
        // Getting challenges
        let issues = [environmentIssues, animalIssues, humanIssues]
        let urlString = "\(K.serverURL)/challenges/from_issues"
        
        let group = DispatchGroup()
        
        var challengesDict = [ValueType: [String]]()
        
        for (i, issue) in issues.enumerated() {
            let parameters = [
                "issues": issue,
                "secret": [K.secretKey]
            ]
            
            group.enter()
            AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
                .response { response in
                    if let e = response.error {
                        debugPrint("Error: \(e)")
                        return
                    }
                    debugPrint("received challenge")
                    if let data = response.data, let challenges = self.parseChallengeJSON(data: data) {
                        //self.delegate?.receivedChallenges(challenges: challenges)
                        if i == 0 {
                            challengesDict[.environment] = challenges
                        } else if i == 1 {
                            challengesDict[.animal] = challenges
                        } else {
                            challengesDict[.human] = challenges
                        }
                    }
                    group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.delegate?.receivedChallenges(challenges: challengesDict)
        }
    }
    
    func postSetupData() {
        guard let email = self.email
        else { return debugPrint("Can't find email") }
        
        let firstName = self.firstName ?? ""
        let lastName = self.lastName ?? ""
        
        // Format challenges
        var challengesArr = [String]()
        var challengeValues = [String]()
        
        for challenge in challenges {
            for value in challenge.value {
                challengesArr.append(value)
                challengeValues.append(challenge.key)
            }
        }
        
        let parameters: [String: [String]] = [
            "email": [email],
            "first_name": [firstName],
            "last_name": [lastName],
            "environment": [(environment ? "true" : "false")],
            "animal": [(animal ? "true" : "false")],
            "human": [(human ? "true" : "false")],
            "environment_issues": environmentIssues,
            "animal_issues": animalIssues,
            "human_issues": humanIssues,
            "challenges": challengesArr,
            "challenge_values": challengeValues,
            "secret": [K.secretKey]
        ]
        
        let urlString = "\(K.serverURL)/api/values"
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .response { response in
                if let e = response.error {
                    debugPrint("Error: \(e)")
                    return
                }
                
                debugPrint("posted setup data")
                self.delegate?.postedSetupData()
        }
    }
    
    private func parseChallengeJSON(data: Data) -> [String]? {
        do {
            let decoder = JSONDecoder()
            let challengeData = try decoder.decode(ChallengeData.self, from: data)
            return challengeData.challenges
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
}
