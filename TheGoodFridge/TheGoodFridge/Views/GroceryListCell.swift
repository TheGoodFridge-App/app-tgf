//
//  GroceryListCell.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol MyTextFieldDelegate {
    func deleteCell(_ textField: UITextField)
}

class MyTextField: UITextField {
    var myDelegate: MyTextFieldDelegate?
    
    override func deleteBackward() {
        if let text = text, text.isEmpty {
            myDelegate?.deleteCell(self)
        }
        super.deleteBackward()
    }
}

class GroceryListCell: UITableViewCell {
    
    let unselectedButtonImage = UIImage(named: "GroceryCellUnselected")
    let selectedButtonImage = UIImage(named: "GroceryCellSelected")
    
    lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = unselectedButtonImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let inputField: MyTextField = {
        let textField = MyTextField()
        textField.font = UIFont(name: "Amiko-Regular", size: 16)
        textField.contentVerticalAlignment = .center
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let separatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.3)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(buttonImageView)
        addSubview(inputField)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let buttonSize: CGFloat = 20
        let buttonMargin: CGFloat = 20
        
        let constraints = [
            //heightAnchor.constraint(equalToConstant: cellHeight),
            buttonImageView.widthAnchor.constraint(equalToConstant: buttonSize),
            buttonImageView.heightAnchor.constraint(equalToConstant: buttonSize),
            buttonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputField.topAnchor.constraint(equalTo: topAnchor),
            inputField.leadingAnchor.constraint(equalTo: buttonImageView.trailingAnchor, constant: buttonMargin),
            inputField.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
