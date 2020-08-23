//
//  ChallengeBox.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/23/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeBox: UIView {

    let circularProgressBar = CircularProgressBar()
    
    let currentChallengeLabel: UILabel = {
        let label = UILabel()
        label.text = "CURRENT CHALLENGE"
        label.font = UIFont(name: "Amiko-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let challengeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont(name: "Amiko-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ChallengeBadgeImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Level 1"
        label.font = UIFont(name: "Amiko-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let levelView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Creating label view
        levelView.translatesAutoresizingMaskIntoConstraints = false
        levelView.backgroundColor = .clear
        levelView.addSubview(badgeImageView)
        levelView.addSubview(levelLabel)
        
        labelStackView.addArrangedSubview(currentChallengeLabel)
        labelStackView.addArrangedSubview(challengeNameLabel)
        labelStackView.addArrangedSubview(levelView)
        
        containerView.addSubview(circularProgressBar)
        containerView.addSubview(labelStackView)
        
        addSubview(containerView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let sideMargin: CGFloat = 20
        let badgeImageViewWidth: CGFloat = 8
        let levelSideMargin: CGFloat = 10
        
        let constraints = [
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            circularProgressBar.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
            circularProgressBar.widthAnchor.constraint(equalTo: circularProgressBar.heightAnchor),
            circularProgressBar.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            circularProgressBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin),
            
            labelStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: circularProgressBar.trailingAnchor, constant: sideMargin),
            
            badgeImageView.widthAnchor.constraint(equalToConstant: badgeImageViewWidth),
            badgeImageView.centerYAnchor.constraint(equalTo: levelView.centerYAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: levelView.leadingAnchor),
            
            levelLabel.centerYAnchor.constraint(equalTo: levelView.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: levelSideMargin),
            
            levelView.heightAnchor.constraint(equalTo: badgeImageView.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius = frame.height / 5
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        //self.clipsToBounds = true
        
        // Set drop shadow
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
}
