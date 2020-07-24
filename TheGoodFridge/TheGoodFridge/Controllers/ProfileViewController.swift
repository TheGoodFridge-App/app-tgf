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

    override func viewDidLoad() {
        super.viewDidLoad()
        ppage.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(ppage)
        setupLayout()
        
        
//        let psv = UIStackView()
//        psv.translatesAutoresizingMaskIntoConstraints = false
//        psv.alignment = .fill
    }
    
    private func setupLayout() {
        let constraints = [
            ppage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            ppage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ppage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ppage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
