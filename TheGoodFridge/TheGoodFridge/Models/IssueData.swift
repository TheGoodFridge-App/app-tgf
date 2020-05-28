//
//  IssueData.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/11/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Foundation

struct IssueData {
    static private let environmentIssues = [
        "Environment Regeneration",
        "Reduced Emissions",
        "Conservation",
        "Biodiversity",
        "Waste Management",
        "Water Management",
        "Air Quality",
        "Pollution Reduction"
    ]
    
    static private let animalIssues = [
        "Appropriate Breeding",
        "Appropriate Transportation",
        "Humane Slaughter",
        "Living Conditions",
        "Handling",
        "Proper Nutrition",
        "Health Management",
        "Access to Outdoors"
    ]
    
    static private let humanIssues = [
        "Sustainable Wages",
        "Gender Equity/Equality",
        "No Child Labor",
        "No Forced Labor",
        "Supporting Small Scale Workers",
        "Safe Environment/Working Conditions",
        "Cultural Identity",
        "Environmental Stewardship"
    ]
    
    static func getEnvironmentIssues() -> [String] {
        return environmentIssues
    }
    
    static func getAnimalIssues() -> [String] {
        return animalIssues
    }
    
    static func getHumanIssues() -> [String] {
        return humanIssues
    }
    
    static func getSelected(type: ValueType, issues: [Int]) -> [String] {
        var selectedIssues: [String]
        if type == .environment {
            selectedIssues = issues.map({ environmentIssues[$0] })
        } else if type == .animal {
            selectedIssues = issues.map({ animalIssues[$0] })
        } else {
            selectedIssues = issues.map({ humanIssues[$0] })
        }
        
        return selectedIssues
    }
    
    static func getAllIssues(values: [Int]) -> [Int: (String, ValueType)] {
        var issuesMap = [Int: (String, ValueType)]()
        var index = 0
        
        for value in values {
            // Environment
            if value == 0 {
                for issue in environmentIssues {
                    issuesMap[index] = (issue, .environment)
                    index += 1
                }
            }
            if value == 1 {
                for issue in animalIssues {
                    issuesMap[index] = (issue, .animal)
                    index += 1
                }
            }
            if value == 2 {
                for issue in humanIssues {
                    issuesMap[index] = (issue, .human)
                    index += 1
                }
            }
        }
        
        return issuesMap
    }
    
}
