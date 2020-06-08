//
//  AddButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/31/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class AddButton: UIView {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "AddButtonImage"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        //backgroundColor = .blue
        //button.backgroundColor = .green
        
        addSubview(button)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let constraints = [
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(frame.size.height)
        layer.cornerRadius = frame.size.height / 2
        layer.shadowColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
            //UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.9
        //layer.shadowPath = UIBezierPath(rect: bounds).cgPath

        button.layer.cornerRadius = layer.cornerRadius
        button.layer.masksToBounds = true
    }
    
}
