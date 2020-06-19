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
    
    let welcomeBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WelcomeBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "LoginButtonEnabled"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1), for: .normal)
        button.setBackgroundImage(UIImage(named: "LoginButtonDisabled"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-SemiBold", size: 25)
        label.textColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        label.text = "The Good Fridge."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        signupButton.addTarget(self, action: #selector(tappedSignupButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        view.addSubview(brandLabel)
        view.addSubview(welcomeBackground)
        view.sendSubviewToBack(welcomeBackground)
        
        setupLayout()
        
    }

    private func setupLayout() {
        let buttonHeight: CGFloat = 50
        let spacing: CGFloat = 50
        
        let constraints = [
            welcomeBackground.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            welcomeBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        let registerVC = RegisterViewController()
        //registerVC.modalPresentationStyle = .fullScreen
        //self.present(registerVC, animated: true, completion: nil)
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func tappedLoginButton() {
        let loginVC = LoginViewController()
        //loginVC.modalPresentationStyle = .fullScreen
        //self.present(loginVC, animated: true, completion: nil)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
}


