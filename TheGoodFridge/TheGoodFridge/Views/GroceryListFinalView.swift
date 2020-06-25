//
//  GroceryListFinalView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class GroceryListFinalView: UIView {

    // Constants
    let interRowSpacing: CGFloat = 12
    let addButton = AddButton()
    
    let tableView: UITableView
    let recommended: [String: [String]]
    let other: [String]
    
    var delegate: GroceryDelegate?
    
    required init(rec: [String: [String]], other: [String]) {
        self.recommended = rec
        self.other = other
        tableView = UITableView(frame: .zero)
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroceryListFinalCell.self, forCellReuseIdentifier: K.groceryCellFinalID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        
        addSubview(tableView)
        addSubview(addButton)
        bringSubviewToFront(addButton)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let margin: CGFloat = 40
        let buttonMargin: CGFloat = 20
        let buttonSize: CGFloat = 60
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: margin / 2),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            addButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addButton.heightAnchor.constraint(equalToConstant: buttonSize),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -buttonMargin),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -buttonMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    @objc func tappedAddButton() {
        delegate?.returnToEdit()
    }
    
}

extension GroceryListFinalView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recommended.count
        } else {
            return other.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.groceryCellFinalID, for: indexPath) as! GroceryListFinalCell
        cell.delegate = delegate
        let rec = Array(recommended.keys)
        if indexPath.section == 0 {
            cell.setText(to: rec[indexPath.row])
            //cell.setRecommended()
            cell.isRecommended = true
            cell.item = rec[indexPath.row]
            cell.recommended = recommended[rec[indexPath.row]] ?? [String]()
        } else {
            cell.setText(to: other[indexPath.row])
        }
        return cell
    }
    
}

extension GroceryListFinalView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 + interRowSpacing
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Recommendations"
        } else if other.count != 0 {
            label.text = "Your Groceries"
        }
        label.font = UIFont(name: "Amiko-SemiBold", size: 18)
        return label
    }
    
}
