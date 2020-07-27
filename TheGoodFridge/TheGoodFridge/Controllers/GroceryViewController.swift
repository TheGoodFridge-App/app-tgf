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
    func checkedPrevItems(items: [String], success: Bool)
    func didGetGroceryItems(rec: [String: [String]], other: [String], purchased: [String: String])
    func returnToEdit()
    func showRecommendations(item: String, products: [String], purchased: String?, cell: ProductDelegate)
}

class GroceryViewController: UIViewController {

    let viewMargin: CGFloat = 30
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
        label.font = UIFont(name: "Amiko-SemiBold", size: 15)
        label.textColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var groceryListEditView = GroceryListEditView(rows: [GroceryListCell()], isEditing: false)
    var groceryListFinalView = GroceryListFinalView(rec: [String: [String]](), other: [String](), purchased: [String: String]())
    let groceryData = GroceryData(items: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.shared.delegate = self
        groceryListEditView.delegate = self
        groceryListFinalView.delegate = self
        groceryData.delegate = self
        
        if let firstName = User.shared.getFirstName() {
            nameLabel.text = "\(firstName)'s Grocery List"
            setupViews()
        }
        
        view.backgroundColor = .white 
    }
    
    private func setupViews() {
        
        
        // Check if grocery data already exists
        groceryData.getGroceryList()
        
        view.addSubview(dateLabel)
        view.addSubview(nameLabel)
        view.addSubview(groceryListEditView)
        view.addSubview(tomatoImageView)
        view.addSubview(groceryBackground)
        view.sendSubviewToBack(groceryBackground)
        view.bringSubviewToFront(groceryListEditView.groceryDoneView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let titleLeadingMargin: CGFloat = 40
        let titleTopMargin: CGFloat = 60
        let intertextSpacing: CGFloat = 5
        
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
            groceryListEditView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: viewMargin),
            groceryListEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewMargin),
            groceryListEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewMargin),
            groceryListEditView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            if let firstName = User.shared.getFirstName() {
                self.nameLabel.text = "\(firstName)'s Grocery List"
                self.setupViews()
            }
        }
    }
    
}

extension GroceryViewController: GroceryDelegate {
    
    func startedEditing() {
        view.bringSubviewToFront(groceryListEditView)
    }
    
    func checkedPrevItems(items: [String], success: Bool) {
        if success {
            groceryData.getRecommendations()
        }
    }
    
    func didGetGroceryItems(rec: [String: [String]], other: [String], purchased: [String: String]) {
        // Load GroceryListFinalView
        print(rec, other)
        self.groceryListEditView.removeFromSuperview()
        
        self.groceryListFinalView = GroceryListFinalView(rec: rec, other: other, purchased: purchased)
        self.groceryListFinalView.delegate = self
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: { self.view.addSubview(self.groceryListFinalView) }, completion: nil)
        self.view.bringSubviewToFront(self.groceryListFinalView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        let constraints = [
            self.groceryListFinalView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: self.viewMargin),
            self.groceryListFinalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.groceryListFinalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.groceryListFinalView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func returnToEdit() {
        groceryListFinalView.removeFromSuperview()
        
        let rowStrings = Array(groceryListFinalView.recommended.keys) + groceryListFinalView.other
        let rows: [GroceryListCell] = rowStrings.map { str in
            let groceryCell = GroceryListCell()
            groceryCell.inputField.text = str
            return groceryCell
        }
        
        groceryListEditView = GroceryListEditView(rows: rows, isEditing: true)
        groceryListEditView.delegate = self
        
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: { self.view.addSubview(self.groceryListEditView) }, completion: nil)
        
        let constraints = [
            groceryListEditView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: viewMargin),
            groceryListEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewMargin),
            groceryListEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewMargin),
            groceryListEditView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func showRecommendations(item: String, products: [String], purchased: String?, cell: ProductDelegate) {
        let recommendVC = RecommendViewController()
        recommendVC.item = item
        recommendVC.selectedProduct = purchased
        recommendVC.products = products
        recommendVC.delegate = cell
        recommendVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            recommendVC.backingImage = self.tabBarController?.view.asImage()
            self.present(recommendVC, animated: false, completion: nil)
        })
    }
    
}
