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
    
    static private let environmentIcons = [
        "EnvironmentRegenerationIcon",
        "ReducedEmissionsIcon",
        "ConservationIcon",
        "BiodiversityIcon",
        "WasteManagementIcon",
        "WaterManagementIcon",
        "AirQualityIcon",
        "PollutionReductionIcon"
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
    
    static private let animalIcons = [
        "AppropriateBreedingIcon",
        "AppropriateTransportationIcon",
        "HumaneSlaughterIcon",
        "LivingConditionIcon",
        "HandlingIcon",
        "ProperNutritionIcon",
        "HealthManagementIcon",
        "OutdoorAccessIcon"
    ]
    
    static private let humanIssues = [
        "Sustainable Wages",
        "Gender Equity/Equality",
        "No Child Labor",
        "No Forced Labor",
        "Small-scale Workers",
        "Working Conditions",
        "Cultural Identity",
        "Community Empowerment"
    ]
    
    static private let humanIcons = [
        "SustainableWagesIcon",
        "GenderEquityIcon",
        "NoChildLaborIcon",
        "NoForcedLaborIcon",
        "SmallScaleWorkerIcon",
        "SafeWorkingConditionsIcon",
        "CulturalIdentityIcon",
        "CommunityEmpowermentIcon",
    ]
    
    static private let images = [
        // environment
        "Environment Regeneration",
        "Reduced Emissions",
        "Conservation",
        "Biodiversity",
        "Waste Management",
        "Water Management",
        "Air Quality",
        "Pollution Reduction",
        // animal
        "Appropriate Breeding",
        "Appropriate Transportation",
        "Humane Slaughter",
        "Living Conditions",
        "Handling",
        "Proper Nutrition",
        "Health Management",
        "Access to Outdoors",
        // human
        "Sustainable Wages",
        "Gender Equity/Equality",
        "No Child Labor",
        "No Forced Labor",
        "Supporting Small Scale Workers",
        "Safe Environment/Working Conditions",
        "Cultural Identity",
        "Environmental Stewardship"
    ]
    
    static func getEnvironmentIssues() -> ([String], [String]) {
        return (environmentIssues, environmentIcons)
    }
    
    static func getAnimalIssues() -> ([String], [String]) {
        return (animalIssues, animalIcons)
    }
    
    static func getHumanIssues() -> ([String], [String]) {
        return (humanIssues, humanIcons)
    }
    
    static func getSelected(type: ValueType, issues: [Int]) -> ([String], [String]) {
        var selectedIssues: [String]
        var selectedIcons: [String]
        
        if type == .environment {
            selectedIssues = issues.map({ environmentIssues[$0] })
            selectedIcons = issues.map({ environmentIcons[$0] })
        } else if type == .animal {
            selectedIssues = issues.map({ animalIssues[$0] })
            selectedIcons = issues.map({ animalIcons[$0] })
        } else {
            selectedIssues = issues.map({ humanIssues[$0] })
            selectedIcons = issues.map({ humanIcons[$0] })
        }
        
        return (selectedIssues, selectedIcons)
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
