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
        
        setTitle("Next", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 18)
        if type == .next {
            backgroundColor = .black
        } else {
            backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
