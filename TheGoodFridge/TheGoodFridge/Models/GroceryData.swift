//
//  GroceryData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Alamofire
import Firebase
import Foundation

enum MethodType {
    case post
    case get
}

enum GroceryType {
    case past
    case split
}

struct PastGroceryData: Codable {
    let grocery_list: [String]?
    let purchased: [String: String]?
}

struct SplitGroceryData: Codable {
    let recommendations: [String: [String]]
    let other: [String]
    let purchased: [String: String]
}

class GroceryData {
    var items: [String]
    var recommendations: [String: [String]]?
    var otherItems: [String]?
    var delegate: GroceryDelegate?
    
    var purchased = [String: String]()
    var user = User()
    
    init(items: [String]) {
        self.items = items
    }
    
    func getGroceryList() {
        let urlString = "\(K.serverURL)/grocery_list/get"
        guard let email = user.email else {
            debugPrint("Could not get user email.")
            return
        }
        
        //let email = "test"
        let parameters: [String: String] = [
            "email": email,
            "secret": K.secretKey
        ]
        
        AF.request(urlString, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
            .validate()
            .responseJSON { response in
                print(response)
                if let e = response.error {
                    debugPrint("Error: \(e)")
                    self.delegate?.checkedPrevItems(items: [String](), success: false)
                    return
                }
                
                if let responseData = response.data {
                    self.parseJSON(type: .past, data: responseData)
                    self.delegate?.checkedPrevItems(items: self.items, success: true)
                }
                
        }
    }
    
    func updateGroceryList() {
        // Split items into recommendations and products that did not get anything
        let urlString = "\(K.serverURL)/grocery_list/update"
        
        guard let email = user.email else {
            debugPrint("Could not get user email.")
            return
        }
        let parameters: [String: [String]] = [
            "email": [email],
            "items": items,
            "secret": [K.secretKey]
        ]
        
        
        
        AF.request(urlString, method: .put, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .responseJSON { response in
                if let error = response.error {
                    debugPrint("Error: \(error)")
                }
                
                if let responseData = response.data {
                    self.parseJSON(type: .split, data: responseData)
                    if let rec = self.recommendations, let other = self.otherItems {
                        self.delegate?.didGetGroceryItems(rec: rec, other: other, purchased: self.purchased)
                    }
                }
        }
    }
    
    func getOrPostRecommendations(type: MethodType) {
        // Split items into recommendations and products that did not get anything
        let urlString = "\(K.serverURL)/grocery_list"
        guard let email = user.email else {
            debugPrint("Could not get user email.")
            return
        }
        let parameters: [String: [String]] = [
            "email": [email],
            "items": items,
            "secret": [K.secretKey]
        ]
        
        let method: HTTPMethod = type == MethodType.post ? .post : .get
        
        AF.request(urlString, method: method, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .responseJSON { response in
                
                if let responseData = response.data {
                    debugPrint("received recommendations")
                    self.parseJSON(type: .split, data: responseData)
                    if let rec = self.recommendations, let other = self.otherItems {
                        self.delegate?.didGetGroceryItems(rec: rec, other: other, purchased: self.purchased)
                    } else {
                        debugPrint("Items are empty")
                        return
                    }
                }
        }
    }
    
    private func parseJSON(type: GroceryType, data: Data) {
        do {
            let decoder = JSONDecoder()
            if type == .split {
                let splitData = try decoder.decode(SplitGroceryData.self, from: data)
                recommendations = splitData.recommendations
                otherItems = splitData.other
                purchased = splitData.purchased
            } else if type == .past {
                let pastData = try decoder.decode(PastGroceryData.self, from: data)
                if let items = pastData.grocery_list, let purchased = pastData.purchased {
                    self.items = items
                    self.purchased = purchased
                }
            }
        }
        catch {
            debugPrint("Could not decode data")
        }
    }

}
