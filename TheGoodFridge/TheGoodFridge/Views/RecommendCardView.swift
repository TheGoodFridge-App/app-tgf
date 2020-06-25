//
//  RecommendCardView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 6/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class RecommendCardView: UIView {

    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Amiko-Bold", size: 20)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.spacing = interItemSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var item = ""
    var products = [String]()
    
    // Constants
    let cardViewMargin: CGFloat = 40.0
    let interItemSpacing: CGFloat = 30.0
    
    required init(item: String, products: [String]) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0.941, green: 0.969, blue: 0.929, alpha: 1)
        self.item = item
        self.products = products
        titleTextView.text = "Here are the recommended products for \(item.lowercased())ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
        
        stackView.addArrangedSubview(titleTextView)
        
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constraints = [
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cardViewMargin),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cardViewMargin),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
