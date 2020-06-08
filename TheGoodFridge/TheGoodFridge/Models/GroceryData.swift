//
//  GroceryData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Alamofire
import Foundation

struct SplitGroceryData: Codable {
    let recommendations: [String]
    let other: [String]
}

class GroceryData {
    var items: [String]
    var recommendations: [String]?
    var otherItems: [String]?
    var delegate: GroceryDelegate?
    
    init(items: [String]) {
        self.items = items
    }
    
    func getRecommendations() {
        // Split items into recommendations and products that did not get anything
        let urlString = "\(K.serverURL)/grocery_list"
        guard let email = User.shared.getEmail() else { return }
        let parameters: [String: [String]] = [
            "email": [email],
            "items": items
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .responseJSON { response in
                
                if let responseData = response.data {
                    debugPrint(response.result)
                    self.parseJSON(data: responseData)
                    if let rec = self.recommendations, let other = self.otherItems {
                        self.delegate?.didGetGroceryItems(rec: rec, other: other)
                    } else {
                        debugPrint("Items are empty")
                        return
                    }
                }
        }
    }
    
    private func parseJSON(data: Data) {
        do {
            let decoder = JSONDecoder()
            let splitData = try decoder.decode(SplitGroceryData.self, from: data)
            recommendations = splitData.recommendations
            otherItems = splitData.other
        }
        catch {
            debugPrint("Could not decode data")
        }
    }

}

extension GroceryData: UserDelegate {
    
    func didGetUserData() {
        getRecommendations()
    }
    
}
