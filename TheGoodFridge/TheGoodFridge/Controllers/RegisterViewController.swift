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
import AuthenticationServices
import CryptoKit

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
    
    let appleSignInButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "AppleSignInImage"), for: .normal)
        button.setTitle("Sign in with Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 15)
        button.imageView?.contentMode = .scaleAspectFill
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
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "XImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
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
        
        appleSignInButton.addTarget(self, action: #selector(tappedAppleButton), for: .touchUpInside)
        
        fieldStackView.addArrangedSubview(firstNameTextField)
        fieldStackView.addArrangedSubview(lastNameTextField)
        fieldStackView.addArrangedSubview(emailTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        
        signupStackView.addArrangedSubview(fieldStackView)
        signupStackView.addArrangedSubview(signupErrorView)
        signupStackView.addArrangedSubview(createButton)
        
        createButton.addTarget(self, action: #selector(tappedCreateButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(googleSignInButton)
        buttonStackView.addArrangedSubview(appleSignInButton)
        
        fullStackView.addArrangedSubview(signupLabel)
        fullStackView.addArrangedSubview(signupStackView)
        fullStackView.addArrangedSubview(dividerView)
        fullStackView.addArrangedSubview(buttonStackView)
        fullStackView.addArrangedSubview(brandLabel)
        
        view.addSubview(fullStackView)
        view.addSubview(signUpBackgroundImage)
        view.addSubview(backButton)
        
        view.sendSubviewToBack(signUpBackgroundImage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let buttonWidth: CGFloat = 264
        let fieldHeight: CGFloat = 150
        let buttonHeight: CGFloat = 60
        let margin: CGFloat = 15
        let backButtonSize: CGFloat = 20
        let backButtonMargin: CGFloat = 25
        
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
            appleSignInButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            appleSignInButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            backButton.widthAnchor.constraint(equalToConstant: backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: backButtonSize),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: backButtonMargin * 2),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: backButtonMargin)
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
                let firstName = self.firstNameTextField.text() ?? ""
                let lastName = self.lastNameTextField.text() ?? ""
                let user = User()
                user.email = email
                user.firstName = firstName
                user.lastName = lastName
                self.presentSetup(user: user)
              }
            }
            UserDefaults.standard.set(true, forKey: "loggedIn")
        }
    }
    
    private func presentSetup(user: User) {
        let setupVC = IntroViewController()
        setupVC.user = user
        setupVC.modalPresentationStyle = .fullScreen
        present(setupVC, animated: true, completion: nil)
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func startSignInWithAppleFlow() -> ASAuthorizationAppleIDRequest {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        request.nonce = sha256(nonce)
        
        return request
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
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
        UserDefaults.standard.set(true, forKey: "loggedIn")
    }
    
    @objc func tappedAppleButton() {
        let request = startSignInWithAppleFlow()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
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
            let user = User()
            user.email = email
            user.firstName = firstName
            user.lastName = lastName
            self.presentSetup(user: user)
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

extension RegisterViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                fatalError("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            }
            
            let name = appleIDCredential.fullName
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (authDataResult, error) in
                if let user = authDataResult?.user {
                    print("Nice! You're now signed in as \(user.uid), email: \(user.email ?? "unknown")")
                    
                    // User is signed in, move to setup
                    let newUser = User()
                    newUser.email = user.email
                    newUser.firstName = name?.givenName
                    newUser.lastName = name?.familyName
                    self.presentSetup(user: newUser)
                }
            }
        }
    }
}

extension RegisterViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
