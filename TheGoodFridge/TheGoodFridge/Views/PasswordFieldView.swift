//
//  PasswordFieldView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/2/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class PasswordFieldView: InputFieldView {
    
    let passwordEye: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "PasswordEye"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    required init(_ placeholder: String, isAutocorrected: Bool) {
        super.init(placeholder, isAutocorrected: false)
        
        textField.isSecureTextEntry = true
        
        passwordEye.addTarget(self, action: #selector(tappedPasswordEye), for: .touchUpInside)
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(passwordEye)
        
        addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            passwordEye.widthAnchor.constraint(equalToConstant: 24),
            stroke.heightAnchor.constraint(equalToConstant: 1),
            stroke.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            stroke.leadingAnchor.constraint(equalTo: leadingAnchor),
            stroke.bottomAnchor.constraint(equalTo: bottomAnchor),
            stroke.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedPasswordEye() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

}
