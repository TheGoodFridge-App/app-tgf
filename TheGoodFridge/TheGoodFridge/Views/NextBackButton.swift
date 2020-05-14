//
//  NextBackButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/11/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

enum ButtonDirection {
    case next
    case back
}

class NextBackButton: UIButton {
    required init(type: ButtonDirection) {
        
        super.init(frame: .zero)

        if type == .next {
            setBackgroundImage(UIImage(named: "NextButtonEnabled"), for: .normal)
            setBackgroundImage(UIImage(named: "NextButtonDisabled"), for: .disabled)
        } else {
            setBackgroundImage(UIImage(named: "BackButtonEnabled"), for: .normal)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
