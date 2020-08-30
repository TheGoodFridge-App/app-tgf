//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import StoreKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    let profilePageView = ProfilePageView()
    var user = User()
    
    let profileChallengesBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileChallengesBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAndViews()
        
        profilePageView.user = user
        
        view.addSubview(profilePageView)
        view.addSubview(profileChallengesBackground)
        view.sendSubviewToBack(profileChallengesBackground)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            profilePageView.topAnchor.constraint(equalTo: view.topAnchor),
            profilePageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profilePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profileChallengesBackground.topAnchor.constraint(equalTo: view.topAnchor),
            profileChallengesBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileChallengesBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileChallengesBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setButtonsAndViews() {
        profilePageView.translatesAutoresizingMaskIntoConstraints = false
        profilePageView.settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
        
        presentReview()
    }
    
    private func presentReview() {
        // If the count has not yet been stored, this will return 0
        var count = UserDefaults.standard.integer(forKey: K.processCompletedCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: K.processCompletedCountKey)

        print("Process completed \(count) time(s)")

        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary") }

        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: K.lastVersionPromptedForReviewKey)

        // Has the process been completed several times and the user has not already been prompted for this version?
        if count >= 4 && currentVersion != lastVersionPromptedForReview {
            let twoSecondsFromNow = DispatchTime.now() + 2.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { 
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(currentVersion, forKey: K.lastVersionPromptedForReviewKey)
            }
        }
    }

}
