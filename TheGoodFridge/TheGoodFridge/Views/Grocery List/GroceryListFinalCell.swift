//
//  GroceryListFinalCell.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/31/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol ProductDelegate {
    func selectedRecommendation(name product: String, item: String)
}

class GroceryListFinalCell: UITableViewCell {

    let selectedButtonImage = UIImage(named: "GroceryCellSelected")
    let interRowSpacing: CGFloat = 12
    var cornerRadius: CGFloat = 15
    var isRecommended = false
    var recommended = [String]()
    var item = ""
    var purchased: String?
    var delegate: GroceryDelegate?
    var user = User()
    
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
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let checkmarkIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "EllipsisImage")
        imageView.alpha = 0.9
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        itemButton.isEnabled = false
        checkmarkIcon.isHidden = true
        itemButton.addTarget(self, action: #selector(tappedItemButton), for: .touchDown)
        containerView.addSubview(itemButton)
        
        containerView.addSubview(checkmarkIcon)
        containerView.bringSubviewToFront(checkmarkIcon)
        
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
    
    func setAttributedText(to text: NSAttributedString) {
        itemButton.setTitle(nil, for: .normal)
        itemButton.setAttributedTitle(text, for: .normal)
    }
    
    func setRecommended() {
        itemButton.isEnabled = true
        checkmarkIcon.isHidden = false
        
        // Add drop shadow to button
        containerView.layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 2, height: 3)
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowPath = UIBezierPath(roundedRect: itemButton.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    @objc func tappedItemButton() {
        delegate?.showRecommendations(item: item, products: recommended, purchased: purchased, cell: self)
    }
    
    private func setupLayout() {
        let margin: CGFloat = 20
        let imageSize: CGFloat = 20
        let iconWidth: CGFloat = 5
        
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
            itemButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkmarkIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkmarkIcon.widthAnchor.constraint(equalToConstant: iconWidth),
            checkmarkIcon.trailingAnchor.constraint(equalTo: itemButton.trailingAnchor, constant: -margin * 1.25)
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

extension GroceryListFinalCell: ProductDelegate {
    
    func selectedRecommendation(name product: String, item: String) {
        purchased = product
        
        checkmarkIcon.image = UIImage(named: "CheckmarkIcon")
        checkmarkIcon.alpha = 1.0
        
        let attributedText = NSMutableAttributedString(string: item, attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 16)!])
        attributedText.append(NSAttributedString(string: "\n\(product)", attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!]))
        setAttributedText(to: attributedText)
        let productManager = ProductManager()
        productManager.user = user
        productManager.postPurchase(purchased: product, item: item.lowercased())
    }
    
}
