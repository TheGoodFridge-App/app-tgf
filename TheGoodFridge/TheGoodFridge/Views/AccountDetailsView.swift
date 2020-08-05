//
//  AccountDetailsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class AccountDetailsView: UIView {
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        addSubview(wrapperView)
        wrapperView.addSubview(backButton)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 62),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 74),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 31.5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
