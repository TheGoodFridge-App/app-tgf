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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 18)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        return button
    }()
    
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
            let button = ValueGoalButton(text: value)
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
        nextButton.alpha = 0.0

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
        let buttonSpacing: CGFloat = 70
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
            nextButton.topAnchor.constraint(equalTo: fullStackView.bottomAnchor, constant: buttonSpacing),
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
    
    @objc func tappedValueButton(sender: UIButton) {
        if sender.backgroundColor == ValueGoalButton.selectedColor {
            if selectedValues.count > 1 {
                sender.backgroundColor = ValueGoalButton.unselectedColor
                selectedValues = selectedValues.filter({$0 != sender.tag})
            }
        } else {
            sender.backgroundColor = ValueGoalButton.selectedColor
            selectedValues.insert(sender.tag)
        }
        
        if !nextButton.isEnabled  {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.isEnabled = true
                self.nextButton.alpha = 1.0
            }
        }
    }
    
    @objc func tappedNextButton() {
        let values = selectedValues.map { num -> ValueType in
            switch num {
            case 0:
                return .environment
            case 1:
                return .animal
            case 2:
                return .human
            default:
                return .error
            }
        }
        delegate?.updateData(values: values)
        delegate?.tappedNextButton()
    }
    
}
