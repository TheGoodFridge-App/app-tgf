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

class ChallengeManager {
    var delegate: ChallengeDelegate?
    
    func getDescriptions(challenges: [String]) {
        let urlString = "\(K.serverURL)/challenges/descriptions"
        print(challenges)
        
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
                    debugPrint(response)
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
            print(data)
            let decoder = JSONDecoder()
            let descriptionData = try decoder.decode(DescriptionData.self, from: data)
            print(descriptionData)
            return descriptionData.description
        }
        catch {
            debugPrint("Could not decode data")
            return nil
        }
    }
}
