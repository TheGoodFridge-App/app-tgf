//
//  GroceryDoneView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class GroceryDoneView: UIView {
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "GreenButtonImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("I'm done!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please fill out all fields."
        label.font = UIFont(name: "Amiko-Regular", size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(doneButton)
        addSubview(errorLabel)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let buttonWidth: CGFloat = 120
        let buttonHeight: CGFloat = 40
        let spacing: CGFloat = 5
        
        let constraints = [
            doneButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            doneButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -spacing)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = frame.size.height / 50
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
}
