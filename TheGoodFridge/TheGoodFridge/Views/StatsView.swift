//
//  StatsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class StatsView: UIView {
    
    let dateLabel = UILabel()
    let numTripsLabel = UILabel()
    let numProductsLabel = UILabel()
    let tripsWordLabel = UILabel()
    let productsWordLabel = UILabel()
    
    let susTripsLabel = UILabel()
    let totalProductsLabel = UILabel()
    
    class stack: UIStackView {
        var stck = UIStackView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.alignment = .leading
            self.spacing = 0
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func changeAxisandDistribution(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
            self.axis = axis
            self.distribution = distribution
        }
    }
    
    let wrapperStack = stack()
    let containerStack = stack()
    let tripsLabelStack = stack()
    let numTripsStack = stack()
    let productsLabelStack = stack()
    let numProductsStack = stack()
    
    let tomatoImage = UIImageView()
    let bagImage = UIImageView()
    let fridgeImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLabels()
        setStacks()
        setImageView()
        
        addSubview(wrapperStack)
        
        wrapperStack.addArrangedSubview(dateLabel)
        wrapperStack.addArrangedSubview(containerStack)
        wrapperStack.addArrangedSubview(tomatoImage)
        
        containerStack.addArrangedSubview(tripsLabelStack)
        containerStack.addArrangedSubview(numTripsStack)
        containerStack.addArrangedSubview(productsLabelStack)
        containerStack.addArrangedSubview(numProductsStack)
        
        
        tripsLabelStack.addArrangedSubview(bagImage)
        tripsLabelStack.addArrangedSubview(susTripsLabel)
        
        numTripsStack.addArrangedSubview(numTripsLabel)
        numTripsStack.addArrangedSubview(tripsWordLabel)
        
        
        productsLabelStack.addArrangedSubview(fridgeImage)
        productsLabelStack.addArrangedSubview(totalProductsLabel)
        
        numProductsStack.addArrangedSubview(numProductsLabel)
        numProductsStack.addArrangedSubview(productsWordLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getDate() -> String {
        let date = "MAY 2020"
        return date
    }
    
    func getTrips() -> String {
        let numTrips = 6
        return String(numTrips)
    }
    
    func getNumProducts() -> String {
        let numProducts = 25
        return String(numProducts)
    }
    
    func changeFont(labelName: UILabel) {
        labelName.font = UIFont(name: "Amiko-Semibold", size: 15)
        labelName.textColor = .darkGray
    }
    
    func setLabels() {
        dateLabel.text = getDate()
        changeFont(labelName: dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        susTripsLabel.text = "SUSTAINABLE TRIPS"
        changeFont(labelName: susTripsLabel)
        susTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        totalProductsLabel.text = "TOTAL ETHICAL PRODUCTS"
        changeFont(labelName: totalProductsLabel)
        totalProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        numTripsLabel.text = getTrips()
        numTripsLabel.font = UIFont(name: "Amiko-Semibold", size: 30)
        numTripsLabel.textColor = .black
        numTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tripsWordLabel.text = "trips"
        tripsWordLabel.font = UIFont(name: "Amiko-Semibold", size: 22)
        tripsWordLabel.textColor = .black
        tripsWordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numProductsLabel.text = getNumProducts()
        numProductsLabel.font = UIFont(name: "Amiko-Semibold", size: 30)
        numProductsLabel.textColor = .black
        numProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productsWordLabel.text = "products"
        productsWordLabel.font = UIFont(name: "Amiko-Semibold", size: 22)
        productsWordLabel.textColor = .black
        productsWordLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setStacks() {
        wrapperStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        containerStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        tripsLabelStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        numTripsStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        productsLabelStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        numProductsStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
    }
    
    func setImageView() {
        tomatoImage.translatesAutoresizingMaskIntoConstraints = false
        tomatoImage.image = UIImage(named: "TomatoImage")
        
        bagImage.translatesAutoresizingMaskIntoConstraints = false
        bagImage.image = UIImage(named: "GroceryIconSelected")
        
        fridgeImage.translatesAutoresizingMaskIntoConstraints = false
        fridgeImage.image = UIImage(named: "ProfileIconUnselected")
    }
    
    
    
    
}
