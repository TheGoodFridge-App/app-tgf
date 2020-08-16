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
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let spacing: CGFloat = 40
    
    let signUpBackgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SignUpBackgroundImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        button.setTitleColor(UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 15)
        button.setBackgroundImage(UIImage(named: "LoginButtonDisabled"), for: .disabled)
        button.setBackgroundImage(UIImage(named: "LoginButtonEnabled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let googleSignInButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "GoogleSignInImage"), for: .normal)
        button.setTitle("Sign in with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 15)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tappedGoogleButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "The Good Fridge."
        label.font = UIFont(name: "Amiko-Regular", size: 12)
        label.textColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
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
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "XImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        
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
        view.addSubview(signUpBackgroundImage)
//        view.addSubview(backButton)
        
        view.sendSubviewToBack(signUpBackgroundImage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let buttonWidth: CGFloat = 264
        let fieldHeight: CGFloat = 200
        let buttonHeight: CGFloat = 60
        let margin: CGFloat = 15
//        let backButtonSize: CGFloat = 20
//        let backButtonMargin: CGFloat = 20
        
        let constraints = [
            signUpBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            signUpBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            googleSignInButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            googleSignInButton.heightAnchor.constraint(equalToConstant: buttonHeight),
//            backButton.widthAnchor.constraint(equalToConstant: backButtonSize),
//            backButton.heightAnchor.constraint(equalToConstant: backButtonSize),
//            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: backButtonMargin),
//            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -backButtonMargin)
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
                createButton.setTitleColor(UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1), for: .normal)
                return
        }
        
        createButton.isEnabled = true
        createButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func tappedGoogleButton() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
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
            let email = user.profile.email
            let firstName = user.profile.givenName
            let lastName = user.profile.familyName
            User.shared.setEmail(to: email)
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
