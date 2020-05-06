//
//  SetupViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    let slides = [UIView]()
    let valueView = ValuesView()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        view.bringSubviewToFront(pageControl)
        view.addSubview(pageControl)
        
        view.addSubview(valueView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let pageControlOffset: CGFloat = 90
        
        let constraints = [
            valueView.topAnchor.constraint(equalTo: view.topAnchor),
            valueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            valueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            valueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -pageControlOffset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
