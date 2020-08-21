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
        
        textField.textColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        textField.font = UIFont(name: "Amiko-Regular", size: 15)
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.5), NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 15)!])
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        if !isAutocorrected {
            textField.autocapitalizationType = .none
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        stroke.backgroundColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
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
