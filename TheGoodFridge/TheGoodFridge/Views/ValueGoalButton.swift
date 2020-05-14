//
//  ValueButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ValueGoalButton: UIButton {

    var selectedImage = UIImage(named: "ValueButtonHighlighted")
    var unselectedImage = UIImage(named: "ValueButtonNormal")
    
    required init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setBackgroundImage(unselectedImage, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Amiko-Bold", size: 18)
        titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(selected: UIImage?, unselected: UIImage?) {
        selectedImage = selected
        unselectedImage = unselected
        setBackgroundImage(unselectedImage, for: .normal)
    }
    
    func isSelected() -> Bool {
        return currentBackgroundImage == selectedImage
    }
    
    func toggle() {
        let backgroundImage = isSelected() ? unselectedImage : selectedImage
        setBackgroundImage(backgroundImage, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 5
    }
    
}
