//
//  StartView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/17/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class StartView: UIView {
    
    var delegate: SlideDelegate?

    let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Semibold", size: 18)
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(startButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 130
        
        let constraints = [
            startButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            startButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startButton.layer.cornerRadius = startButton.frame.size.height / 2
    }
    
    @objc func tappedStartButton() {
        delegate?.tappedStartButton()
    }
    
}
