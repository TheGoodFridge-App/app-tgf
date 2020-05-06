//
//  InputFieldView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/2/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class InputFieldView: UIView {
    
    let textField = UITextField()
    let stroke = UIView()
    var placeholder: String
    
    required init(_ placeholder: String, isAutocorrected: Bool) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        if !isAutocorrected {
            textField.autocapitalizationType = .none
        }
        
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        stroke.translatesAutoresizingMaskIntoConstraints = false
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField)
        addSubview(stroke)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func text() -> String? {
        return textField.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constraints = [
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            stroke.heightAnchor.constraint(equalToConstant: 1),
            stroke.topAnchor.constraint(equalTo: textField.bottomAnchor),
            stroke.leadingAnchor.constraint(equalTo: leadingAnchor),
            stroke.bottomAnchor.constraint(equalTo: bottomAnchor),
            stroke.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
