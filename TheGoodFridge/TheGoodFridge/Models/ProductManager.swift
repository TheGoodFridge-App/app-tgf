//
//  ProductManager.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 7/1/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Alamofire
import Foundation

struct ProductManager {
    static func postPurchase(purchased: String, item: String) {
        let urlString = "\(K.serverURL)/grocery_list/purchased"
        guard let email = User.shared.getEmail() else {
            debugPrint("Could not get user email.")
            return
        }
        let parameters: [String: String] = [
            "email": email,
            "brand": purchased,
            "product": item,
            "secret": K.secretKey
        ]
        
        AF.request(urlString, method: .put, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).validate()
            .response { response in
                if let error = response.error {
                    debugPrint("Error updating grocery list with new purchase: \(error)")
                    return
                }
                
                debugPrint("updated grocery list")
        }
    }
}
