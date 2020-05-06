//
//  DividerView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/3/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class DividerView: UIView {

    let leftDivider: UIView = {
        let divider = UIView()
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        divider.backgroundColor = .black
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let rightDivider: UIView = {
        let divider = UIView()
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = UIFont(name: "Amiko-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(leftDivider)
        addSubview(rightDivider)
        addSubview(orLabel)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let spacing: CGFloat = 40
        
        let constraints = [
            orLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            orLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftDivider.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftDivider.heightAnchor.constraint(equalToConstant: 1),
            leftDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftDivider.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -spacing),
            rightDivider.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightDivider.heightAnchor.constraint(equalToConstant: 1),
            rightDivider.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: spacing),
            rightDivider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
