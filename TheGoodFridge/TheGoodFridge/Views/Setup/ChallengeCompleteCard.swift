//
//  ChallengeCompleteCard.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/15/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeCompleteCard: UIView {
    
    let backgroundColors: [ValueType: UIColor] = [
        .environment: UIColor(red: 1, green: 0.953, blue: 0.902, alpha: 1),
        .animal: UIColor(red: 1, green: 0.937, blue: 0.937, alpha: 1),
        .human: UIColor(red: 0.842, green: 0.944, blue: 1, alpha: 1)
    ]
    
    let dotColors: [ValueType: UIColor] = [
        .environment: UIColor(red: 0.973, green: 0.706, blue: 0.525, alpha: 1),
        .animal: UIColor(red: 0.961, green: 0.576, blue: 0.592, alpha: 1),
        .human: UIColor(red: 0.291, green: 0.691, blue: 0.908, alpha: 1)
    ]
    
    let dotView: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        return dotView
    }()
    
    let challengeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Bold", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = margin
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let margin: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(dotView)
        addSubview(challengeLabel)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetChallenge() {
        challengeLabel.text = nil
        self.backgroundColor = .clear
        dotView.backgroundColor = .clear
    }
    
    func setChallenge(text: String, type: ValueType) {
        challengeLabel.text = text
        
        if let backgroundColor = backgroundColors[type], let dotColor = dotColors[type] {
            self.backgroundColor = backgroundColor
            dotView.backgroundColor = dotColor
        }
    }
    
    private func setupLayout() {
        let cardHeight: CGFloat = 100
        
        let constraints = [
            heightAnchor.constraint(equalToConstant: cardHeight),
            dotView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dotView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            dotView.widthAnchor.constraint(equalToConstant: cardHeight / 2),
            dotView.heightAnchor.constraint(equalToConstant: cardHeight / 2),
            challengeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            challengeLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: margin),
            challengeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotView.layer.cornerRadius = dotView.frame.height / 2
        dotView.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 8
    }
    
}
