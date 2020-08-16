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
    var selectedProduct: String?
    var productButtons = [RecommendProductButton]()
    var delegate: ProductDelegate?
    
    // Constants
    let cardViewMargin: CGFloat = 40.0
    let interItemSpacing: CGFloat = 30.0
    
    required init(item: String, products: [String]) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0.941, green: 0.969, blue: 0.929, alpha: 1)
        self.item = item
        self.products = products
        
        titleTextView.text = "Here are the recommended products for \(item.lowercased())"
        
        // adding each product to the stack view
        stackView.addArrangedSubview(titleTextView)
        for product in self.products {
            let productButton = RecommendProductButton()
            productButton.setText(to: product)
            productButton.addTarget(self, action: #selector(tappedProductButton), for: .touchUpInside)
            stackView.addArrangedSubview(productButton)
            productButtons.append(productButton)
        }
        
        // adding fourth option to the stack view
        let otherProductButton = RecommendProductButton()
        let otherText: NSMutableAttributedString = NSMutableAttributedString(string: "Couldn't find any of the \(products.count) in store?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1).cgColor, NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!])
        let otherBlackText = NSAttributedString(string: "\nSelect this option if you found \(item.lowercased()) labeled \"organic\"!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor, NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 12)!])
        otherText.append(otherBlackText)
        otherProductButton.setAttributedText(to: otherText)
        otherProductButton.product = "other"
        otherProductButton.addTarget(self, action: #selector(tappedProductButton), for: .touchUpInside)
        stackView.addArrangedSubview(otherProductButton)
        productButtons.append(otherProductButton)
        
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
    }
    
    func setSelected(product: String?) {
        selectedProduct = product
        if let productButton = productButtons.first(where: { $0.product == product }) {
            productButton.toggle()
        }
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
    
    @objc func tappedProductButton(_ sender: RecommendProductButton) {
        if selectedProduct == nil {
            sender.toggle()
            selectedProduct = sender.product
            delegate?.selectedRecommendation(name: selectedProduct ?? "", item: item)
        } else if selectedProduct != sender.product {
            let oldProduct = productButtons.first(where: { $0.product == selectedProduct })
            if let old = oldProduct {
                old.toggle()
                selectedProduct = sender.product
            }
            sender.toggle()
            delegate?.selectedRecommendation(name: selectedProduct ?? "", item: item)
        }
    }
    
}
