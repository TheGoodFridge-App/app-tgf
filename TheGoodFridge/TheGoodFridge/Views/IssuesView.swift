//
//  IssuesView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class IssuesView: UIView {

    var values: [ValueType]? {
        didSet {
            generateValueString()
        }
    }
    var valueStr: String = ""
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(introTextView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateValueString() {
        print("here")
        
        if let values = values {
            let len = values.count
            if len > 0 {
                var str: String
                for i in 0..<len {
                    switch values[i] {
                    case .environment:
                        str = "environment"
                    case .animal:
                        str = "animal rights"
                    case .human:
                        str = "human rights"
                    default:
                        str = "error"
                    }
                    valueStr += "\(str)"
                    if len == 2 && i == 0 {
                        valueStr += " and "
                    } else if len == 3 {
                        if i == 0 {
                            valueStr += ", "
                        } else if i == 1 {
                            valueStr += ", and "
                        }
                    }
                }
            }
        }

        let bigText = NSMutableAttributedString(
            string: "You picked \(self.valueStr)!\n\nWhat are some specific issues important to you?",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
        introTextView.attributedText = bigText
        introTextView.textAlignment = .center
    }
    
    private func setupLayout() {
        let textMargin: CGFloat = 70
        
        let constraints = [
            introTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            introTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            introTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textMargin),
            introTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
