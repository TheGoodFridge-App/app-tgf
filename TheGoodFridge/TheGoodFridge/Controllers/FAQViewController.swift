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
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let faqPage = FAQView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        faqPage.translatesAutoresizingMaskIntoConstraints = false
        setButtonTargets()
        
        view.addSubview(wrapperView)
        wrapperView.addSubview(faqPage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            faqPage.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            faqPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            faqPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            faqPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setButtonTargets() {
        faqPage.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
    }
    
    @objc func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
