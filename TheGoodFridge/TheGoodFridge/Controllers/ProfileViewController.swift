//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var ppage = ProfilePageView()
    var settingsPage = SettingsView()
    var accountDetailsPage = AccountDetailsView()

    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    
    let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAndViews()

        wrapperView.addSubview(ppage)
        wrapperView.addSubview(settingsPage)
        wrapperView.addSubview(accountDetailsPage)
    
        view.addSubview(wrapperView)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            ppage.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
            ppage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0),
            ppage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
            ppage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0),
            
            settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
            accountDetailsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            accountDetailsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            accountDetailsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            accountDetailsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
        
//        settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
//        settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
//        settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
//        settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    }
    
    
    func setButtonsAndViews() {
        ppage.translatesAutoresizingMaskIntoConstraints = false
        settingsPage.translatesAutoresizingMaskIntoConstraints = false
        accountDetailsPage.translatesAutoresizingMaskIntoConstraints = false
        
        ppage.isHidden = false
        settingsPage.isHidden = true
        accountDetailsPage.isHidden = true
        
        ppage.settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
        
        settingsPage.backButton.addTarget(self, action: #selector(settingsPageTappedBackButton), for: .touchUpInside)
        settingsPage.accDetailsButton.addTarget(self, action: #selector(tappedAccountDetailsButton), for: .touchUpInside)
        
        
        accountDetailsPage.backButton.addTarget(self, action: #selector(tappedBackToSettingsButton), for: .touchUpInside)
    }
    
    
    @objc func tappedSettingsButton() {
        ppage.isHidden = true
        accountDetailsPage.isHidden = true
        
        settingsPage.isHidden = false
    }
    
    @objc func settingsPageTappedBackButton() {
        settingsPage.isHidden = true
        accountDetailsPage.isHidden = true
        
        ppage.isHidden = false
    }
    
    @objc func tappedAccountDetailsButton() {
        settingsPage.isHidden = true
        ppage.isHidden = true
        
        accountDetailsPage.isHidden = false
    }
    
    @objc func tappedBackToSettingsButton() {
        ppage.isHidden = true
        accountDetailsPage.isHidden = true
        
        settingsPage.isHidden = false
    }
    
    
    func setView(view: UIView) {
        settingsPage.translatesAutoresizingMaskIntoConstraints = false
        settingsPage = SettingsView()
        wrapperView.addSubview(settingsPage)
        settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
        settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    }

}
