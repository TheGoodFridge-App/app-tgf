//
//  PrivacyPolicyView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class PrivacyPolicyView: UIView {
    
    let privacyLabel = UILabel()
    
    let introHeading = UIView()
    
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        return button
    } ()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    let viewInScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setLabels()
        setHeadings()
        
        addSubview(wrapperView)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(privacyLabel)
        wrapperView.addSubview(scrollView)
        scrollView.addSubview(viewInScrollView)
        
        viewInScrollView.addSubview(introHeading)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            wrapperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 57),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 69),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 31.5),
            
            privacyLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            privacyLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -5),
            privacyLabel.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: 27),
            
            scrollView.topAnchor.constraint(equalTo: privacyLabel.bottomAnchor, constant: 21),
            scrollView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
            viewInScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewInScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewInScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewInScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewInScrollView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            introHeading.topAnchor.constraint(equalTo: viewInScrollView.topAnchor),
            introHeading.bottomAnchor.constraint(equalTo: viewInScrollView.topAnchor, constant: 33),
            introHeading.leadingAnchor.constraint(equalTo: viewInScrollView.leadingAnchor),
            introHeading.trailingAnchor.constraint(equalTo: viewInScrollView.trailingAnchor),
            
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabel(label: UILabel, text: String, font: UIFont, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = text
        label.font = font
        label.textColor = color
    }
    
    func setLabels() {
        changeLabel(label: privacyLabel, text: "Privacy Policy", font: UIFont(name: "Amiko-Regular", size: 24)!, color: .black)
    }
    
    func changeHeading(view: UIView, text: String) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1)
        view.addBorders(edges: [.bottom], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        
        let label = UILabel()
        changeLabel(label: label, text: ("    " + text), font: UIFont(name: "Amiko-Bold", size: 14)!, color: UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1))
        view.addSubview(label)
        
        let constraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setHeadings() {
        changeHeading(view: introHeading, text: "Introduction")
    }
    
}
