//
//  GroceryViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol GroceryDelegate {
    func startedEditing()
    func didGetGroceryItems(data: GroceryData)
}

class GroceryViewController: UIViewController {

    let groceryBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GroceryBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tomatoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TomatoImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let dateStr = dateFormatter.string(from: date)
        label.text = dateStr
        label.font = UIFont(name: "Amiko-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        if let firstName = User.shared.getFirstName() {
            label.text = "\(firstName)'s Grocery List"
        }
        label.font = UIFont(name: "Amiko-SemiBold", size: 15)
        label.textColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let groceryListView = GroceryListEditView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.shared.delegate = self
        groceryListView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white 
    }
    
    private func setupViews() {
        if let firstName = User.shared.getFirstName() {
            nameLabel.text = "\(firstName)'s Grocery List"
        }
        
        view.addSubview(dateLabel)
        view.addSubview(nameLabel)
        view.addSubview(groceryListView)
        view.addSubview(tomatoImageView)
        view.addSubview(groceryBackground)
        view.sendSubviewToBack(groceryBackground)
        view.bringSubviewToFront(groceryListView.groceryDoneView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let titleLeadingMargin: CGFloat = 40
        let titleTopMargin: CGFloat = 60
        let intertextSpacing: CGFloat = 5
        let viewMargin: CGFloat = 30
        let tomatoSize: CGFloat = 250
        let offset: CGFloat = 50
        
        let constraints = [
            groceryBackground.topAnchor.constraint(equalTo: view.topAnchor),
            groceryBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            groceryBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            groceryBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tomatoImageView.widthAnchor.constraint(equalToConstant: tomatoSize),
            tomatoImageView.heightAnchor.constraint(equalToConstant: tomatoSize),
            tomatoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset / 3),
            tomatoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset),
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: titleTopMargin),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titleLeadingMargin),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titleLeadingMargin),
            nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: intertextSpacing),
            groceryListView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: viewMargin),
            groceryListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewMargin),
            groceryListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewMargin),
            groceryListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension GroceryViewController: UserDelegate {
    
    func didGetUserData() {
        DispatchQueue.main.async {
            self.setupViews()
        }
    }
    
}

extension GroceryViewController: GroceryDelegate {
    
    func startedEditing() {
        view.bringSubviewToFront(groceryListView)
    }
    
    func didGetGroceryItems(data: GroceryData) {
        // Load GroceryListFinalView
    }
    
}
