//
//  ValuesView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ValuesView: UIView {

    let value1 = ValueGoalButton(text: "Value 1", type: .value)
    let value2 = ValueGoalButton(text: "Value 2", type: .value)
    let value3 = ValueGoalButton(text: "Value 3", type: .value)
    
    lazy var valueButtons = [value1, value2, value3]
    var curValue = 0
    
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
    
    let spacing: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for (i, value) in valueButtons.enumerated() {
            value.addTarget(self, action: #selector(tappedValueButton), for: .touchUpInside)
            value.tag = i
        }
        
        backgroundColor = .white
        
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = spacing
        bottomStackView.distribution = .fill

        bottomStackView.addArrangedSubview(value2)
        bottomStackView.addArrangedSubview(value3)

        fullStackView.axis = .vertical
        fullStackView.spacing = spacing
        fullStackView.distribution = .fill
        fullStackView.alignment = .center

        fullStackView.addArrangedSubview(value1)
        fullStackView.addArrangedSubview(bottomStackView)

        addSubview(fullStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for value in valueButtons {
            value.layer.cornerRadius = value.frame.height / 5
        }
        
        let constraints = [
            fullStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            fullStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedValueButton(sender: UIButton) {
        for value in valueButtons {
            value.backgroundColor = ValueGoalButton.unselectedColor
        }
        
        sender.backgroundColor = ValueGoalButton.selectedColor
        curValue = sender.tag
    }
    
}
