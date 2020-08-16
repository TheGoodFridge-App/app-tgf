//
//  AccountDetailsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/8/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AccountDetailsViewController: UIViewController {
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let accountDetailsPage = AccountDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        accountDetailsPage.translatesAutoresizingMaskIntoConstraints = false
        setButtonTargets()
        
        view.addSubview(wrapperView)
        wrapperView.addSubview(accountDetailsPage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            accountDetailsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            accountDetailsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            accountDetailsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            accountDetailsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setButtonTargets() {
        accountDetailsPage.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
    }
    
    @objc func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
