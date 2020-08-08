//
//  SettingsViewController.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SettingsViewController: UIViewController {
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let settingsPage = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        settingsPage.translatesAutoresizingMaskIntoConstraints = false
        setButtonTargets()
        
        view.addSubview(wrapperView)
        wrapperView.addSubview(settingsPage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [

            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setButtonTargets() {
        settingsPage.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        settingsPage.signOutButton.addTarget(self, action: #selector(tappedSignOutButton), for: .touchUpInside)
        settingsPage.accDetailsButton.addTarget(self, action: #selector(tappedAccountDetailsButton), for: .touchUpInside)
        settingsPage.privacyButton.addTarget(self, action: #selector(tappedPrivacyPageButton), for: .touchUpInside)
        
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @objc func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedSignOutButton() {
        GIDSignIn.sharedInstance()?.signOut()  //Auth.auth().signOut()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedAccountDetailsButton() {
        let accountVC = AccountDetailsViewController()
        accountVC.modalPresentationStyle = .fullScreen
        self.present(accountVC, animated: true, completion: nil)
    }
    
    @objc func tappedPrivacyPageButton() {
        let privacyVC = PrivacyPolicyViewController()
        privacyVC.modalPresentationStyle = .fullScreen
        self.present(privacyVC, animated: true, completion: nil)
    }
}
