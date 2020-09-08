//
//  SettingsItemCellTableViewCell.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 9/2/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SettingsItemCell: UITableViewCell {
    
    let entryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ArrowIndicatorImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(entryLabel)
        addSubview(arrowIndicator)
        addSubview(separatorView)
        
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
        entryLabel.text = text
    }
    
    private func setupLayout() {
        let margin: CGFloat = 30
        
        
        let constraints = [
            entryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            entryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            arrowIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    
        NSLayoutConstraint.activate(constraints)
    }

}
