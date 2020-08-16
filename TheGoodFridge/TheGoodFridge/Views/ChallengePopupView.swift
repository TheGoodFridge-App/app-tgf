//
//  ChallengePopupView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/1/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengePopupView: UIView {

    let label: UILabel = {
        let l = UILabel()
        l.text = "Test"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .cyan
        addSubview(label)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let constraints = [
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
