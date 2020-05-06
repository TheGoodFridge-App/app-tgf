//
//  RegisterViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 4/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController {
    
    let spacing: CGFloat = 40
    
    let firstNameTextField = InputFieldView("First Name", isAutocorrected: true)
    let lastNameTextField = InputFieldView("Last Name", isAutocorrected: true)
    let emailTextField = InputFieldView("Email", isAutocorrected: false)
    let passwordTextField = PasswordFieldView("Password", isAutocorrected: false)
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Regular", size: 20)
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
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
    
    let signupErrorView = SignupErrorView()
    let dividerView = DividerView()
    
    lazy var fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        
        view.backgroundColor = .white
        
        createButton.isEnabled = false
        
        [firstNameTextField, lastNameTextField, emailTextField, passwordTextField].forEach({
            $0.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        })
        
        fieldStackView.addArrangedSubview(firstNameTextField)
        fieldStackView.addArrangedSubview(lastNameTextField)
        fieldStackView.addArrangedSubview(emailTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        
        signupStackView.addArrangedSubview(fieldStackView)
        signupStackView.addArrangedSubview(signupErrorView)
        signupStackView.addArrangedSubview(createButton)
        
        createButton.addTarget(self, action: #selector(tappedCreateButton), for: .touchUpInside)
        
        fullStackView.addArrangedSubview(signupLabel)
        fullStackView.addArrangedSubview(signupStackView)
        fullStackView.addArrangedSubview(dividerView)
        fullStackView.addArrangedSubview(googleSignInButton)
        fullStackView.addArrangedSubview(brandLabel)
        
        view.addSubview(fullStackView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let fieldHeight: CGFloat = 200
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
            createButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            createButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            dividerView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            googleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            googleSignInButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        createButton.layer.cornerRadius = createButton.frame.size.height / 5
        
        googleSignInButton.layer.cornerRadius = googleSignInButton.frame.size.height / 5
    }
    
    @objc func tappedCreateButton() {
        if let email = emailTextField.text(), let password = passwordTextField.text() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              if let e = error {
                self.signupErrorView.label.text = e.localizedDescription
                print(e.localizedDescription)
                return
              } else {
                  // Navigate to the ChatViewController
                User.shared.setFirstName(to: self.firstNameTextField.text())
                User.shared.setLastName(to: self.lastNameTextField.text())
                User.shared.setEmail(to: self.emailTextField.text())
                self.presentSetup()
              }
            }
        }
    }
    
    private func presentSetup() {
        let setupVC = IntroViewController()
        setupVC.modalPresentationStyle = .fullScreen
        present(setupVC, animated: true, completion: nil)
    }

    @objc func editingChanged() {
        guard let firstName = firstNameTextField.text(), !firstName.isEmpty,
            let lastName = lastNameTextField.text(), !lastName.isEmpty,
            let email = emailTextField.text(), !email.isEmpty,
            let password = passwordTextField.text(), !password.isEmpty else {
                createButton.isEnabled = false
                createButton.setTitleColor(.black, for: .normal)
                createButton.backgroundColor = .white
                return
        }
        
        createButton.isEnabled = true
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = .black
    }
    
}

// MARK: - GIDSignInDelegate
extension RegisterViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            self.signupErrorView.label.text = error.localizedDescription
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        LoginManager.googleCredential = credential
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            // User is signed in, move to setup
            let firstName = user.profile.givenName
            let lastName = user.profile.familyName
            User.shared.setFirstName(to: firstName)
            User.shared.setLastName(to: lastName)
            self.presentSetup()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
