//
//  GroceryListFinalCell.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/31/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class GroceryListFinalCell: UITableViewCell {

    let selectedButtonImage = UIImage(named: "GroceryCellSelected")
    let interRowSpacing: CGFloat = 12
    var cornerRadius: CGFloat = 15
    var isRecommended = false
    var recommended = [String]()
    var item = ""
    var delegate: GroceryDelegate?
    
    lazy var dotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = selectedButtonImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.isUserInteractionEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let itemButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemButton.isEnabled = false
        itemButton.addTarget(self, action: #selector(tappedItemButton), for: .touchDown)
        containerView.addSubview(itemButton)
        addSubview(dotImageView)
        addSubview(containerView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setText(to text: String) {
        itemButton.setTitle(text, for: .normal)
    }
    
    func setRecommended() {
        itemButton.isEnabled = true
        
        // Add drop shadow to button
        containerView.layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 2, height: 3)
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowPath = UIBezierPath(roundedRect: itemButton.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    @objc func tappedItemButton() {
        delegate?.showRecommendations(item: item, products: recommended)
    }
    
    private func setupLayout() {
        let margin: CGFloat = 20
        let imageSize: CGFloat = 20
        
        let constraints = [
            dotImageView.widthAnchor.constraint(equalToConstant: imageSize),
            dotImageView.heightAnchor.constraint(equalToConstant: imageSize),
            dotImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -interRowSpacing / 2),
            dotImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: dotImageView.trailingAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -interRowSpacing),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            itemButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            itemButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            itemButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemButton.layer.cornerRadius = cornerRadius
        
        itemButton.layer.masksToBounds = true
        
        if isRecommended {
            setRecommended()
        }
    }

}
