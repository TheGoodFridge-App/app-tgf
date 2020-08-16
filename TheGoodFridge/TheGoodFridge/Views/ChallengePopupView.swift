//
//  ChallengePopupView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/1/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengePopupView: UIView {
    
    let environmentColor = UIColor(red: 0.973, green: 0.706, blue: 0.525, alpha: 1)
    let animalColor = UIColor(red: 0.961, green: 0.576, blue: 0.592, alpha: 0.61)
    let humanColor = UIColor(red: 0.616, green: 0.839, blue: 0.961, alpha: 1)
    var startFrame = CGRect.zero

    let headerTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = environmentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .darkGray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle("select", for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 16)
        return button
    }()
    
    var curChallenge: String?
    var delegate: ChallengeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        clipsToBounds = true
        isUserInteractionEnabled = true
        spinner.startAnimating()
        
        // Fire API request for challenge description
        selectButton.addTarget(self, action: #selector(tappedSelectButton), for: .touchUpInside)
        
        headerView.addSubview(headerTextView)
        addSubview(headerView)
        addSubview(spinner)
        addSubview(bodyTextView)
        addSubview(selectButton)
        bringSubviewToFront(bodyTextView)
        
        setupLayout()
    }
    
    public func setInfo(challenge: String, type: ValueType) {
        curChallenge = challenge
        if type == .environment {
            headerView.backgroundColor = environmentColor
            selectButton.backgroundColor = environmentColor
        } else if type == .animal {
            headerView.backgroundColor = animalColor
            selectButton.backgroundColor = animalColor
        } else if type == .human {
            headerView.backgroundColor = humanColor
            selectButton.backgroundColor = humanColor
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrText = NSMutableAttributedString(string: challenge,
                                                 attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Bold", size: 24)!,
                                                              NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let value: String
        if type == .environment {
            value = "Environment"
        } else if type == .animal {
            value = "Animal"
        } else {
            value = "Human"
        }
        attrText.append(NSAttributedString(string: "\n\(value)",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle]))

        headerTextView.attributedText = attrText
    }
    
    public func setDescription(to description: Content) {
        spinner.stopAnimating()
        let attributedText = NSMutableAttributedString(string: "\(description.description)\n\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 13)!])
        var bullets = ""
        for impact in description.impact {
            bullets += "\u{2022} \(impact)\n"
        }
        attributedText.append(NSAttributedString(string: bullets, attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 13)!]))
        bodyTextView.attributedText = attributedText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedSelectButton() {
        delegate?.selectedChallenge(challenge: curChallenge)
    }
    
    private func setupLayout() {
        let bodyMargin: CGFloat = 25
        let buttonWidth: CGFloat = 120
        let buttonHeight: CGFloat = 40
        
        let constraints = [
            headerTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTextView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            bodyTextView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: bodyMargin / 2),
            bodyTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bodyMargin),
            bodyTextView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -bodyMargin / 2),
            bodyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bodyMargin),
            selectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            selectButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            selectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bodyMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 20
        selectButton.layer.cornerRadius = selectButton.frame.height / 2
    }
    
}
