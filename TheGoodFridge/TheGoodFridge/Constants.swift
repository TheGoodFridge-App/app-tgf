//
//  Constants.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/11/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation

struct K {
    static let issueCellID = "issueCellID"
    static let groceryCellID = "groceryCellID"
    static let challengeCellID = "challengeCellID"
    static let groceryCellFinalID = "groceryCellFinalID"
    static let settingsCellID = "settingsCellID"
    //static let serverURL = "http://127.0.0.1:5000"
    static let serverURL = "https://the-good-fridge.herokuapp.com"
    static let secretKey = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    static let lastVersionPromptedForReviewKey = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "myLastVersionPromptedKey"
    static let processCompletedCountKey = "myLastProcessCompletedCountKey-\(K.lastVersionPromptedForReviewKey)"
}
