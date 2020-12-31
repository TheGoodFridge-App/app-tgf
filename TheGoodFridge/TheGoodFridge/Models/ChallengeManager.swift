//
//  ChallengeData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/2/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Alamofire
import Foundation

struct DescriptionData: Codable {
    let description: Content
}

struct Content: Codable {
    let name: String
    let description: String
    let impact: [String]
}

struct UserChallengeData: Codable {
    let challenges: [UserChallenge]
}

struct UserChallenge: Codable {
    let name: String
    let current: Int
    let level: Int
    let level_total: Int
    let value: String
}

struct UserHistory: Codable {
    let history: [UserChallenge]
}

class ChallengeManager {
    var delegate: ChallengeDelegate?
    var profileDelegate: ProfileChallengeDelegate?
    var user = User()
    
    func getDescriptions(challenges: [String]) {
        let urlString = "\(K.serverURL)/challenges/descriptions"
        
        let group = DispatchGroup()
        var descriptions = [String: Content]()
        
        for challenge in challenges {
            group.enter()
            
            let parameters = [
                "challenge": challenge,
                "secret": K.secretKey
            ]
            
            AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
                .response { response in
                    group.leave()
                    if let error = response.error {
                        return debugPrint("Error getting descriptions for challenges: \(error)")
                    }
                    debugPrint("received description for challenge")
                    if let data = response.data {
                        if let content = self.parseDescriptionJSON(data: data) {
                            descriptions[content.name] = content
                        }
                    }
            }
        }
        
        group.notify(queue: .main) {
            self.delegate?.didGetDescriptions(descriptions: descriptions)
        }
    }
    
    private func parseDescriptionJSON(data: Data) -> Content? {
        do {
            let decoder = JSONDecoder()
            let descriptionData = try decoder.decode(DescriptionData.self, from: data)
            return descriptionData.description
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
    func getCurrentChallenges() {
        guard let email = user.email else {
            debugPrint("getCurrentChallenges: email not found")
            return
        }
        
        let parameters = [
            "email": email,
            "secret": K.secretKey
        ]
        
        let urlString = "\(K.serverURL)/challenges/get"
        
        AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .responseJSON { response in
                if let error = response.error {
                    return debugPrint("Error getting user's current challenges: \(error)")
                }
                debugPrint("received user challenges")
                
                if let data = response.data {
                    let userChallenges = self.parseCurrentJSON(data: data)
                    self.profileDelegate?.didGetChallenges(challenges: userChallenges)
                }
        }
    }
    
    func getCompletedChallenges() {
        guard let email = user.email else {
            debugPrint("getCompletedChallenges: email not found")
            return
        }
        
        let parameters = [
            "email": email,
            "secret": K.secretKey
        ]
        
        let urlString = "\(K.serverURL)/challenges/completed"
        
        AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .responseJSON { response in
                if let error = response.error {
                    return debugPrint("Error getting user's completed challenges: \(error)")
                }
                debugPrint("received user challenges")
                
                if let data = response.data {
                    let userChallenges = self.parseCompletedJSON(data: data)
                    self.profileDelegate?.didGetCompletedChallenges(challenges: userChallenges)
                }
        }
    }
    
    private func parseCurrentJSON(data: Data) -> [UserChallenge]? {
        do {
            let decoder = JSONDecoder()
            let userChallengeData = try decoder.decode(UserChallengeData.self, from: data)
            return userChallengeData.challenges
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
    private func parseCompletedJSON(data: Data) -> [UserChallenge]? {
        do {
            let decoder = JSONDecoder()
            let userHistory = try decoder.decode(UserHistory.self, from: data)
            return userHistory.history
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
    
}
