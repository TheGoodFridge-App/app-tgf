//
//  SetupData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation

struct SetupData {
    var environment = false
    var human = false
    var animal = false
    
    mutating func setEnvironment() {
        environment = true
    }
    
    mutating func setHuman() {
        human = true
    }
    
    mutating func setAnimal() {
        animal = true
    }
}
