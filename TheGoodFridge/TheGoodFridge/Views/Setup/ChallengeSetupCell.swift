//
//  ChallengeSetupCell.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/1/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeSetupCell: UICollectionViewCell {
    
    // Background images
    let challengeButton = ChallengeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(challengeButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(to text: String) {
        challengeButton.setTitle(text, for: .normal)
    }
    
    func setBackgroundImages(type: ValueType) {
        challengeButton.setBackgroundImages(type: type)
    }
    
    private func setupLayout() {
        let constraints = [
            challengeButton.topAnchor.constraint(equalTo: topAnchor),
            challengeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            challengeButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            challengeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
}
