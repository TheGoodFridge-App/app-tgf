//
//  ChallengeCompleteView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/12/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeCompleteView: UIView {
    
    lazy var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = interCardSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let startButton: NextBackButton = {
        let button = NextBackButton(type: .start)
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: NextBackButton = {
        let button = NextBackButton(type: .back)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var challengeTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        var bigText = NSMutableAttributedString(
            string: "Here are the challenges you've selected.",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
        let smallText = NSAttributedString(
            string: "\n\nYou're now ready to start your next ethical shopping adventure!",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 14)!]
        )
        bigText.append(smallText)
        textView.attributedText = bigText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // Constants
    let interCardSpacing: CGFloat = 10
    let cardMargin: CGFloat = 75
    
    var challenges = [(ValueType, String)]()
    var delegate: SlideDelegate?
    var challengeCards = [ChallengeCompleteCard(), ChallengeCompleteCard(), ChallengeCompleteCard()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardStackView.addArrangedSubview(challengeTextView)
        for card in challengeCards {
            cardStackView.addArrangedSubview(card)
        }
        
        addSubview(cardStackView)
        addSubview(startButton)
        addSubview(backButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChallenges(challenges: [(ValueType, String)]) {
        // reset challenges
        for i in 0..<self.challengeCards.count {
            challengeCards[i].resetChallenge()
        }
        self.challenges = challenges
        for i in 0..<challenges.count {
            let (type, text) = challenges[i]
            challengeCards[i].setChallenge(text: text, type: type)
        }
    }
    
    private func setupLayout() {
        let navButtonWidth: CGFloat = 130
        let navButtonHeight: CGFloat = 50
        let navButtonSpacing: CGFloat = 25
        let navButtonMargin: CGFloat = 50
        let topMargin: CGFloat = 100
        
        for card in challengeCards {
            card.leadingAnchor.constraint(equalTo: cardStackView.leadingAnchor).isActive = true
            card.trailingAnchor.constraint(equalTo: cardStackView.trailingAnchor).isActive = true
        }
        
        let constraints = [
            cardStackView.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            cardStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            backButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            backButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            backButton.topAnchor.constraint(equalTo: cardStackView.bottomAnchor, constant: navButtonSpacing),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: navButtonMargin),
            startButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            startButton.topAnchor.constraint(equalTo: cardStackView.bottomAnchor, constant: navButtonSpacing),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -navButtonMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedStartButton() {
        startButton.isEnabled = false
        delegate?.tappedStartButton()
        startButton.isEnabled = true
    }
    
    @objc func tappedBackButton() {
        backButton.isEnabled = false
        delegate?.tappedBackButton()
        backButton.isEnabled = true
    }
    
}
