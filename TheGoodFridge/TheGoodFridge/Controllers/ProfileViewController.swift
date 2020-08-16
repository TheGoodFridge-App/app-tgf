//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    var ppage = ProfilePageView()
    
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
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setButtonsAndViews() {
        ppage.translatesAutoresizingMaskIntoConstraints = false
        ppage.settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
    }
    
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }

}
