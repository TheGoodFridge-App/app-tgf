//
//  SignupErrorView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SignupErrorView: UIView {

    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Amiko-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
