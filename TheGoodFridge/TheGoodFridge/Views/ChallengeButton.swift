//
//  ChallengeButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/1/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeButton: UIButton {

    let environmentUnselected = UIImage(named: "EnvironmentChallengeUnselected")
    let environmentSelected = UIImage(named: "EnvironmentChallengeSelected")
    let humanUnselected = UIImage(named: "HumanChallengeUnselected")
    let humanSelected = UIImage(named: "HumanChallengeSelected")
    let animalUnselected = UIImage(named: "AnimalChallengeUnselected")
    let animalSelected = UIImage(named: "AnimalChallengeSelected")
    
    var selectedImage: UIImage?
    var unselectedImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont(name: "Amiko-Bold", size: 15)
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.textAlignment = .center
        titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelected() -> Bool {
        return currentBackgroundImage == selectedImage
    }
    
    func setSelected(_ selected: Bool) {
        setBackgroundImage(selected ? selectedImage : unselectedImage, for: .normal)
    }
    
    func setBackgroundImages(type: ValueType) {
        switch type {
        case .environment:
            selectedImage = environmentSelected
            unselectedImage = environmentUnselected
        case .animal:
            selectedImage = animalSelected
            unselectedImage = animalUnselected
        case .human:
            selectedImage = humanSelected
            unselectedImage = humanUnselected
        default:
            break
        }
        
        setBackgroundImage(unselectedImage, for: .normal)
    }
    
}
