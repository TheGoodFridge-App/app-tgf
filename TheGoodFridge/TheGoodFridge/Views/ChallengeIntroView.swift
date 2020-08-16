//
//  ChallengeIntroView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 7/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeIntroView: UIView {

    let introTextView: UITextView = {
        let textView = UITextView()
        textView.text = "We selected challenges based on what you care about to help you contribute to a more sustainable and equitable world."
        textView.font = UIFont(name: "Amiko-SemiBold", size: 21)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let nextButton: NextBackButton = {
        let button = NextBackButton(type: .next)
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: NextBackButton = {
        let button = NextBackButton(type: .back)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    var delegate: SlideDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(introTextView)
        addSubview(nextButton)
        addSubview(backButton)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedNextButton() {
        nextButton.isEnabled = false
        delegate?.tappedNextButton()
        nextButton.isEnabled = true
    }
    
    @objc func tappedBackButton() {
        backButton.isEnabled = false
        delegate?.tappedBackButton()
        backButton.isEnabled = true
    }
    
    private func setupLayout() {
        let textWidth: CGFloat = 250
        let offset: CGFloat = 50
        let navButtonWidth: CGFloat = 130
        let navButtonHeight: CGFloat = 50
        let navButtonSpacing: CGFloat = 140
        let navButtonMargin: CGFloat = 50
        
        let constraints = [
            introTextView.widthAnchor.constraint(equalToConstant: textWidth),
            introTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            introTextView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -offset),
            backButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            backButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -navButtonSpacing),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: navButtonMargin),
            nextButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -navButtonSpacing),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -navButtonMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
