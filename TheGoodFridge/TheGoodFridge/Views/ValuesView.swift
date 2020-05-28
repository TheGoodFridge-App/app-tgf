//
//  ValuesView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

enum ValueType {
    case environment
    case animal
    case human
    case error
}

class ValuesView: UIView {

    let values = ["Environment", "Animal\nRights", "Human\nRights"]
    var valueButtons = [ValueGoalButton]()
    var selectedValues = Set<Int>()
    
    let setupBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SetupBackground1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fullStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let nextButton = NextBackButton(type: .next)
    
    let introTextView: UITextView = {
        let textView = UITextView()
        var bigText = NSMutableAttributedString(
            string: "What values are important to you?",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
//        let smallText = NSAttributedString(
//            string: "text text text text text text text",
//            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!]
//        )
//        bigText.append(smallText)
        textView.attributedText = bigText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let spacing: CGFloat = 25
    var delegate: SlideDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //translatesAutoresizingMaskIntoConstraints = false
        
        for (i, value) in values.enumerated() {
            let button = ValueGoalButton()
            button.setTitle(value, for: .normal)
            button.addTarget(self, action: #selector(tappedValueButton), for: .touchUpInside)
            button.tag = i
            valueButtons.append(button)
        }
        
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = spacing
        bottomStackView.distribution = .fill

        fullStackView.axis = .vertical
        fullStackView.spacing = spacing
        fullStackView.distribution = .fill
        fullStackView.alignment = .center

        fullStackView.addArrangedSubview(valueButtons[0])
        bottomStackView.addArrangedSubview(valueButtons[1])
        bottomStackView.addArrangedSubview(valueButtons[2])
        fullStackView.addArrangedSubview(bottomStackView)
        
        nextButton.isEnabled = false
        //nextButton.alpha = 0.0
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)

        addSubview(fullStackView)
        addSubview(nextButton)
        addSubview(introTextView)

        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let valueButtonHeight: CGFloat = 130
        let valueButtonWidth: CGFloat = 130
        let nextButtonHeight: CGFloat = 50
        let nextButtonWidth: CGFloat = 130
        let buttonSpacing: CGFloat = 140
        let textSpacing: CGFloat = 50
        let textMargin: CGFloat = 90
        
        for button in valueButtons {
            button.widthAnchor.constraint(equalToConstant: valueButtonWidth).isActive = true
            button.heightAnchor.constraint(equalToConstant: valueButtonHeight).isActive = true
        }
        
        let constraints = [
            fullStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            fullStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: nextButtonWidth),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -buttonSpacing),
            introTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            introTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textMargin),
            introTextView.bottomAnchor.constraint(equalTo: fullStackView.topAnchor, constant: -textSpacing),
            introTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        for value in valueButtons {
//            value.layer.cornerRadius = value.frame.size.height / 5
//        }
        
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
    }
    
    @objc func tappedValueButton(sender: ValueGoalButton) {
        if sender.isSelected() {
            if selectedValues.count > 1 {
                sender.toggle()
                selectedValues = selectedValues.filter({$0 != sender.tag})
            }
        } else {
            sender.toggle()
            selectedValues.insert(sender.tag)
        }
        
        self.nextButton.isEnabled = true
    }
    
    @objc func tappedNextButton() {
        delegate?.setValues(values: selectedValues)
        delegate?.tappedNextButton()
    }
    
}
