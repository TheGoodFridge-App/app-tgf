//
//  SettingsSectionTitleView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 9/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SettingsSectionTitleView: UIView {

    let entryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Bold", size: 14)
        label.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(entryLabel)
        addSubview(separatorView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideSeparatorView() {
        separatorView.isHidden = true
    }
    
    func setText(to text: String) {
        entryLabel.text = text
    }
    
    private func setupLayout() {
        let leftMargin: CGFloat = 24
        
        let constraints = [
            entryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            entryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftMargin),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
