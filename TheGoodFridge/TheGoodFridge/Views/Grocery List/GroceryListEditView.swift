//
//  GroceryListView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class GroceryListEditView: UIView {
    
    let tableView: UITableView
    var rows = [GroceryListCell()]
    var rowStrings = [String()]
    var groceryItems = [String]()
    var startCell: GroceryListCell?
    var returnTapped = false
    let groceryDoneView = GroceryDoneView()
    var delegate: GroceryDelegate?
    let isEditing: Bool
    var groceryData = GroceryData(items: [String]())
    var hasGroceryList = false
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "Amiko-Bold", size: 16)!
        let need = NSMutableAttributedString(string: "Need ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 131/255, green: 191/255, blue: 105/255, alpha: 1).cgColor,
            NSAttributedString.Key.font: font
        ])
        let some = NSAttributedString(string: "some ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 245/255, green: 147/255, blue: 151/255, alpha: 1).cgColor,
            NSAttributedString.Key.font: font
        ])
        let food = NSAttributedString(string: "food ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 230/255, green: 143/255, blue: 96/255, alpha: 1).cgColor,
            NSAttributedString.Key.font: font
        ])
        let here = NSAttributedString(string: "here.", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 121/255, green: 191/255, blue: 224/255, alpha: 1).cgColor,
            NSAttributedString.Key.font: font
        ])
        need.append(some)
        need.append(food)
        need.append(here)
        label.attributedText = need
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(rows: [GroceryListCell], isEditing: Bool) {
        tableView = UITableView(frame: .zero)
        self.rows = rows
        self.rowStrings = rows.map({ $0.inputField.text ?? "" })
        self.isEditing = isEditing
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroceryListCell.self, forCellReuseIdentifier: K.groceryCellID)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        groceryDoneView.errorLabel.isHidden = true
        groceryDoneView.doneButton.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        
        addSubview(tableView)
        addSubview(groceryDoneView)
        addSubview(placeholderLabel)
        
        if isEditing {
            placeholderLabel.isHidden = true
            groceryDoneView.isHidden = false
        } else {
            groceryDoneView.isHidden = true
        }
        
        bringSubviewToFront(groceryDoneView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let margin: CGFloat = 20
        let doneViewHeight: CGFloat = 120
        let safeArea = safeAreaLayoutGuide
        
        let constraints = [
            groceryDoneView.heightAnchor.constraint(equalToConstant: doneViewHeight),
            groceryDoneView.leadingAnchor.constraint(equalTo: leadingAnchor),
            groceryDoneView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            groceryDoneView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            tableView.bottomAnchor.constraint(equalTo: groceryDoneView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -margin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 50

        layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = frame.size.height / 50
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    @objc func tappedDoneButton() {
        for cell in rows {
            if let text = cell.inputField.text, text.isEmpty {
                groceryDoneView.errorLabel.isHidden = false
                return
            }
        }
        
        groceryDoneView.errorLabel.isHidden = true
        
        groceryItems = rows.map({ $0.inputField.text ?? "" })
        
        groceryData.items = groceryItems
        groceryData.delegate = delegate
        print("uwu: \(hasGroceryList)")
        if hasGroceryList {
            groceryData.updateGroceryList()
        } else {
            groceryData.getOrPostRecommendations(type: .post)
        }
    }
}

extension GroceryListEditView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(rows.map({ $0.inputField.text }))
        let cell = tableView.dequeueReusableCell(withIdentifier: K.groceryCellID, for: indexPath) as! GroceryListCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.inputField.text = rowStrings[indexPath.row]
        cell.inputField.delegate = self
        //cell.inputField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        if startCell == nil && !isEditing {
            startCell = cell
            cell.inputField.placeholder = "insert grocery item"
            cell.buttonImageView.image = UIImage(named: "GroceryCellPlaceholder")
        }
        
        rows[indexPath.row] = cell
        
        if returnTapped {
            cell.inputField.becomeFirstResponder()
            returnTapped = false
        }
        return cell
    }
    
//    @objc func editingChanged(_ sender: UITextField) {
//        if let text = sender.text, text.isEmpty {
//            groceryDoneView.errorLabel.isHidden = false
//        } else {
//            groceryDoneView.errorLabel.isHidden = true
//        }
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if rows.count > 1 && editingStyle == UITableViewCell.EditingStyle.delete {
            rows[indexPath.row].inputField.text = ""
            rows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groceryItems.append(rows[indexPath.row].inputField.text ?? "")
    }
    
}

extension GroceryListEditView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension GroceryListEditView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let index = rows.firstIndex(where: { $0.inputField == textField }) ?? -1
        print(index)
        if index >= 0 {
            rowStrings[index] = rows[index].inputField.text ?? rowStrings[index]
            let groceryCell = GroceryListCell()
            groceryCell.inputField.text = ""
            rows.insert(groceryCell, at: index + 1)
            rowStrings.insert("", at: index + 1)
            returnTapped = true
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: index + 1, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let startCell = startCell, !returnTapped {
            startCell.buttonImageView.image = startCell.unselectedButtonImage
            placeholderLabel.isHidden = true
            groceryDoneView.isHidden = false
            delegate?.startedEditing()
        }
    }
    
}

