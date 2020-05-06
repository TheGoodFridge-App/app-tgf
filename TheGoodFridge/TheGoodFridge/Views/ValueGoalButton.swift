//
//  ValueButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

enum TypeButton {
    case value
    case goal
}

class ValueGoalButton: UIButton {

    static let selectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let unselectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    var typeButton: TypeButton
    
    required init(text: String, type: TypeButton) {
        self.typeButton = type
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = ValueGoalButton.unselectedColor
        setTitle(text, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Amiko-Bold", size: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonWidth: CGFloat
        var buttonHeight: CGFloat
        
        if typeButton == .value {
            buttonWidth = 130
            buttonHeight = 130
        } else {
            buttonWidth = 135
            buttonHeight = 115
        }
        
        let constraints = [
            widthAnchor.constraint(equalToConstant: buttonWidth),
            heightAnchor.constraint(equalToConstant: buttonHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
