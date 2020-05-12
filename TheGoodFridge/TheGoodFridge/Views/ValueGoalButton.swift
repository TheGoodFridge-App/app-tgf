//
//  ValueButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ValueGoalButton: UIButton {

    var selectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unselectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    
    required init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = unselectedColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Amiko-Bold", size: 18)
        titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColors(selected: UIColor, unselected: UIColor) {
        selectedColor = selected
        unselectedColor = unselected
    }
    
    func isSelected() -> Bool {
        return backgroundColor == selectedColor
    }
    
    func toggle() {
        backgroundColor = isSelected() ? unselectedColor : selectedColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 5
    }
    
}
