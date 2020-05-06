//
//  LoginViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/3/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let spacing: CGFloat = 40
    
    let emailTextField = InputFieldView("Email", isAutocorrected: false)
    let passwordTextField = PasswordFieldView("Password", isAutocorrected: false)
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Regular", size: 20)
        label.text = "Log In"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "The Good Fridge."
        label.font = UIFont(name: "Amiko-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = spacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let signupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let signupErrorView = SignupErrorView()
    let dividerView = DividerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        
        view.backgroundColor = .white
        
        loginButton.isEnabled = false
        
        [emailTextField, passwordTextField].forEach({
            $0.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        })
        
        fieldStackView.addArrangedSubview(emailTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        
        signupStackView.addArrangedSubview(fieldStackView)
        signupStackView.addArrangedSubview(signupErrorView)
        signupStackView.addArrangedSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        
        fullStackView.addArrangedSubview(signupLabel)
        fullStackView.addArrangedSubview(signupStackView)
        fullStackView.addArrangedSubview(dividerView)
        fullStackView.addArrangedSubview(googleSignInButton)
        fullStackView.addArrangedSubview(brandLabel)
        
        view.addSubview(fullStackView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let fieldHeight: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let margin: CGFloat = 15
        
        let constraints = [
            fullStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fullStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            signupStackView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            signupStackView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            fieldStackView.heightAnchor.constraint(equalToConstant: fieldHeight),
            fieldStackView.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor, constant: margin),
            fieldStackView.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor, constant: -margin),
            signupLabel.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor, constant: margin),
            signupErrorView.heightAnchor.constraint(equalToConstant: spacing),
            signupErrorView.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            signupErrorView.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            dividerView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            googleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            googleSignInButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 5
        
        googleSignInButton.layer.cornerRadius = googleSignInButton.frame.size.height / 5
    }
    
    @objc func tappedLoginButton() {
        if let email = emailTextField.text(), let password = passwordTextField.text() {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.signupErrorView.label.text = e.localizedDescription
                    print(e.localizedDescription)
                } else {
                    // MARK: - TODO: Profile Segue
                }
            }
        }
    }

    @objc func editingChanged() {
        guard let email = emailTextField.text(), !email.isEmpty,
            let password = passwordTextField.text(), !password.isEmpty else {
                loginButton.isEnabled = false
                loginButton.setTitleColor(.black, for: .normal)
                loginButton.backgroundColor = .white
                return
        }
        
        loginButton.isEnabled = true
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
    }
    
}

// MARK: - GIDSignInDelegate
extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        LoginManager.googleCredential = credential
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                self.signupErrorView.label.text = error.localizedDescription
                print(error)
                return
            }
            // User is signed in
            print("cool")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
