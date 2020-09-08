//
//  FAQViewController.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class FAQViewController: UIViewController {
    
    let faqLabel: UILabel = {
        let label = UILabel()
        label.text = "FAQ"
        label.font = UIFont(name: "Amiko-Regular", size: 24)!
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(UIImage(named: "SettingsBackImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let faqPage = FAQView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = faqLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.hidesBackButton = true
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        view.addSubview(faqPage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
        
            faqPage.topAnchor.constraint(equalTo: view.topAnchor),
            faqPage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            faqPage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            faqPage.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
