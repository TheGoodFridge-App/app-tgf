//
//  ViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 4/11/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import GoogleSignIn

class WelcomeViewController: UIViewController {
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-SemiBold", size: 25)
        label.text = "The Good Fridge."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        signupButton.addTarget(self, action: #selector(tappedSignupButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        view.addSubview(brandLabel)
        
        setupLayout()
        
    }

    private func setupLayout() {
        let buttonHeight: CGFloat = 50
        let spacing: CGFloat = 50
        
        let constraints = [
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            signupButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: spacing),
            brandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brandLabel.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -spacing),
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signupButton.layer.cornerRadius = signupButton.frame.height / 5
        signupButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = signupButton.frame.height / 5
        loginButton.layer.masksToBounds = true
    }
    
    @objc func tappedSignupButton() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func tappedLoginButton() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
}


