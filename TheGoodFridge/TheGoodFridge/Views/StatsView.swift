//
//  StatsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class StatsView: UIView {
    
    let view = UIView()
        
    
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
    
    let blankLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    let blankLabel2: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    let wrapperView = UIView()
    
    let containerStack = stack()
    let tripsLabelStack = stack()
    let numTripsStack = stack()
    let productsLabelStack = stack()
    let numProductsStack = stack()
    
    let tomatoImage = UIImageView()
    let bagImage = UIImageView()
    let fridgeImage = UIImageView()
    
    let tomatoView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLabels()
        setStacks()
        setImageView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wrapperView)
        
        wrapperView.addSubview(dateLabel)

        tripsLabelStack.addArrangedSubview(bagImage)
        tripsLabelStack.addArrangedSubview(susTripsLabel)
         wrapperView.addSubview(tripsLabelStack)

        numTripsStack.addArrangedSubview(numTripsLabel)
        numTripsStack.addArrangedSubview(tripsWordLabel)
        wrapperView.addSubview(numTripsStack)
        
        productsLabelStack.addArrangedSubview(fridgeImage)
        productsLabelStack.addArrangedSubview(totalProductsLabel)
        wrapperView.addSubview(productsLabelStack)

        numProductsStack.addArrangedSubview(numProductsLabel)
        numProductsStack.addArrangedSubview(productsWordLabel)
        wrapperView.addSubview(numProductsStack)
        
        tomatoView.translatesAutoresizingMaskIntoConstraints = false
        
        tomatoView.addSubview(tomatoImage)
        wrapperView.addSubview(tomatoView)
        
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            //Wrapper Stack constraints
            wrapperView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            //Add Date Label Constraints
            dateLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 23),
            dateLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 50),
            
            //tripsLabelStack
            tripsLabelStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 50),
            tripsLabelStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 35),
            tripsLabelStack.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 130),
            //susTripsLabel Constraints
            susTripsLabel.topAnchor.constraint(equalTo: tripsLabelStack.topAnchor),
            susTripsLabel.leadingAnchor.constraint(equalTo: tripsLabelStack.leadingAnchor, constant: 23),

            //numTripsStack Constraints
            numTripsStack.topAnchor.constraint(equalTo: susTripsLabel.bottomAnchor, constant: 5),
            numTripsStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 50),
            numTripsStack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            //numTripsLabel Constraints
            numTripsLabel.topAnchor.constraint(equalTo: numTripsStack.topAnchor),
            numTripsLabel.leadingAnchor.constraint(equalTo: numTripsStack.leadingAnchor),
            //tripsWordLabel Constraint
            tripsWordLabel.bottomAnchor.constraint(equalTo: numTripsLabel.bottomAnchor, constant: 10),
            tripsWordLabel.leadingAnchor.constraint(equalTo: susTripsLabel.leadingAnchor, constant: 5),

            //productsLabel Stack Constraints
            productsLabelStack.topAnchor.constraint(equalTo: numTripsStack.bottomAnchor, constant: 13),
            productsLabelStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 50),
            //totalProductsLabel Constraints
            totalProductsLabel.topAnchor.constraint(equalTo: productsLabelStack.topAnchor),
            totalProductsLabel.leadingAnchor.constraint(equalTo: productsLabelStack.leadingAnchor, constant: 27),

            //numProductsStack Constraints
            numProductsStack.topAnchor.constraint(equalTo: totalProductsLabel.bottomAnchor, constant: 7),
            numProductsStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 50),
            //numProductsLabel Constraints
            numProductsLabel.topAnchor.constraint(equalTo: numProductsStack.topAnchor),
            numProductsLabel.leadingAnchor.constraint(equalTo: numProductsStack.leadingAnchor),
            //productsWordLabel Constraint
            productsWordLabel.bottomAnchor.constraint(equalTo: numProductsLabel.bottomAnchor, constant: 10),
            productsWordLabel.leadingAnchor.constraint(equalTo: numProductsLabel.trailingAnchor),
            
            
            tomatoView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -20),
            tomatoView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
        labelName.font = UIFont(name: "Amiko-Regular", size: 14)
        labelName.textColor = .gray
    }
    
    func setLabels() {
        dateLabel.text = getDate()
        changeFont(labelName: dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        susTripsLabel.text = "      SUSTAINABLE TRIPS"
        changeFont(labelName: susTripsLabel)
        susTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        totalProductsLabel.text = "     TOTAL ETHICAL PRODUCTS"
        changeFont(labelName: totalProductsLabel)
        totalProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        numTripsLabel.text = getTrips()
        numTripsLabel.font = UIFont(name: "Amiko-Regular", size: 48)
        numTripsLabel.textColor = .black
        numTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tripsWordLabel.text = "   trips"
        tripsWordLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        tripsWordLabel.textColor = .black
        tripsWordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numProductsLabel.text = getNumProducts()
        numProductsLabel.font = UIFont(name: "Amiko-Regular", size: 48)
        numProductsLabel.textColor = .black
        numProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productsWordLabel.text = "   products"
        productsWordLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        productsWordLabel.textColor = .black
        productsWordLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setStacks() {
        containerStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        tripsLabelStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        numTripsStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        productsLabelStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        numProductsStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
    }
    
    func setImageView() {
        let tomatoFrame = CGRect(x: -200, y: -200, width: 240, height: 200)
        tomatoImage.image = UIImage(named: "ProfileTomatoImage")
        tomatoImage.frame = tomatoFrame
        tomatoImage.clipsToBounds = true
        tomatoImage.contentMode = .scaleAspectFit
        
        let bagFrame = CGRect(x: 0, y: 0, width: 18, height: 21)
        bagImage.image = UIImage(named: "LocalMall")
        bagImage.frame = bagFrame
        bagImage.contentMode = .scaleAspectFill
        
        let fridgeFrame = CGRect(x: 0, y: 0, width: 16, height: 20)
        fridgeImage.image = UIImage(named: "KitchenFridge")
        fridgeImage.frame = fridgeFrame
        fridgeImage.contentMode = .scaleAspectFill
    }
}
