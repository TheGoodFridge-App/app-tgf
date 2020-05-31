//
//  GroceryData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation

struct GroceryData {
    var items: [String]
    var recommendations = [String]()
    var otherItems = [String]()
    var delegate: GroceryDelegate?
    
    func getRecommendations() {
        // Split items into recommendations and products that did not get anything
    }
}
