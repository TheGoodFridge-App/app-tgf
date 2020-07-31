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
        wrapperStack.addArrangedSubview(blankLabel)
        wrapperStack.addArrangedSubview(containerStack)
        
        wrapperStack.addArrangedSubview(tomatoImage)
        
        wrapperStack.addArrangedSubview(view)
        setView()
        
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
        
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            //Wrapper Stack constraints
            wrapperStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            wrapperStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            wrapperStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            wrapperStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            //Add Date Label Constraints
            dateLabel.topAnchor.constraint(equalTo: wrapperStack.topAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor, constant: 0),
            dateLabel.heightAnchor.constraint(equalTo: wrapperStack.heightAnchor, multiplier: 1/20),
            
            //Blank Label Constraints
            blankLabel.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor),
            blankLabel.trailingAnchor.constraint(equalTo: wrapperStack.trailingAnchor),
            blankLabel.heightAnchor.constraint(equalTo: wrapperStack.heightAnchor, multiplier: 1/20),
            
            //containerStack constraints
            containerStack.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor, constant: 0),
            containerStack.heightAnchor.constraint(equalTo: wrapperStack.heightAnchor, multiplier: 10/20),
            containerStack.widthAnchor.constraint(equalTo: wrapperStack.widthAnchor),
            
            //tripsLabel Stack Constraints
            tripsLabelStack.heightAnchor.constraint(equalTo: containerStack.heightAnchor, multiplier: 1/8),
            tripsLabelStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 0),
            tripsLabelStack.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            //bagImage constraints
            bagImage.widthAnchor.constraint(equalTo: tripsLabelStack.widthAnchor, multiplier: 1/20),
            bagImage.heightAnchor.constraint(equalTo: tripsLabelStack.heightAnchor, multiplier: 1),
            //susTripsLabel Constraints
            susTripsLabel.bottomAnchor.constraint(equalTo: tripsLabelStack.bottomAnchor),
            susTripsLabel.widthAnchor.constraint(equalTo: tripsLabelStack.widthAnchor, multiplier: 19/20),
            
            
            //numTripsStack Constraints
            numTripsStack.heightAnchor.constraint(equalTo: containerStack.heightAnchor, multiplier: 4/15),
            numTripsStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 0),
            numTripsStack.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            numTripsStack.topAnchor.constraint(equalTo: tripsLabelStack.bottomAnchor),
            //numTripsLabel Constraints
            numTripsLabel.bottomAnchor.constraint(equalTo: numTripsStack.bottomAnchor, constant: -10),
            numTripsLabel.leadingAnchor.constraint(equalTo: numTripsStack.leadingAnchor),
            //tripsWordLabel Constraint
            tripsWordLabel.bottomAnchor.constraint(equalTo: numTripsStack.bottomAnchor, constant: -7),
            tripsWordLabel.leadingAnchor.constraint(equalTo: numTripsLabel.trailingAnchor),
            
            
            //productsLabel Stack Constraints
            productsLabelStack.heightAnchor.constraint(equalTo: containerStack.heightAnchor, multiplier: 1/8),
            productsLabelStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 0),
            productsLabelStack.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            productsLabelStack.topAnchor.constraint(equalTo: numTripsStack.bottomAnchor),
            //fridgeImage constraints
            fridgeImage.widthAnchor.constraint(equalTo: productsLabelStack.widthAnchor, multiplier: 1/20),
            fridgeImage.heightAnchor.constraint(equalTo: productsLabelStack.heightAnchor, multiplier: 1),
            //totalProductsLabel Constraints
            totalProductsLabel.bottomAnchor.constraint(equalTo: productsLabelStack.bottomAnchor),
            totalProductsLabel.widthAnchor.constraint(equalTo: productsLabelStack.widthAnchor, multiplier: 19/20),
            
            
            
            //numProductsStack Constraints
            numProductsStack.heightAnchor.constraint(equalTo: containerStack.heightAnchor, multiplier: 4/15),
            numProductsStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 0),
            numProductsStack.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            numProductsStack.topAnchor.constraint(equalTo: productsLabelStack.bottomAnchor),
            //numProductsLabel Constraints
            numProductsLabel.topAnchor.constraint(equalTo: productsLabelStack.bottomAnchor, constant: 7),
            numProductsLabel.leadingAnchor.constraint(equalTo: numProductsStack.leadingAnchor),
            //productsWordLabel Constraint
            productsWordLabel.topAnchor.constraint(equalTo: productsLabelStack.bottomAnchor, constant: 14.5),
            productsWordLabel.leadingAnchor.constraint(equalTo: numProductsLabel.trailingAnchor),
            
//            //blankLabel2 Constraints
//            blankLabel2.heightAnchor.constraint(equalTo: containerStack.heightAnchor, multiplier: 5/8),
//            blankLabel2.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            
            //TomatoImage constraints
            tomatoImage.trailingAnchor.constraint(equalTo: wrapperStack.trailingAnchor, constant: 75),
            //tomatoImage.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor, constant: 300),
            //tomatoImage.heightAnchor.constraint(equalTo: wrapperStack.heightAnchor, multiplier: 10/20),
            tomatoImage.bottomAnchor.constraint(equalTo: wrapperStack.bottomAnchor),
            //tomatoImage.widthAnchor.constraint(equalTo: wrapperStack.widthAnchor, multiplier: 1/2)
            
            
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
        numTripsLabel.font = UIFont(name: "Amiko-SemiBold", size: 35)
        numTripsLabel.textColor = .black
        numTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tripsWordLabel.text = " trips"
        tripsWordLabel.font = UIFont(name: "Amiko-SemiBold", size: 25)
        tripsWordLabel.textColor = .black
        tripsWordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numProductsLabel.text = getNumProducts()
        numProductsLabel.font = UIFont(name: "Amiko-SemiBold", size: 35)
        numProductsLabel.textColor = .black
        numProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productsWordLabel.text = " products"
        productsWordLabel.font = UIFont(name: "Amiko-SemiBold", size: 25)
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
        tomatoImage.image = UIImage(named: "ProfileTomatoImage")
        tomatoImage.clipsToBounds = true
        //tomatoImage.backgroundColor = .blue
        //tomatoImage.contentMode = .bottomRight
        tomatoImage.contentMode = .scaleAspectFit
        
        
        
        
        bagImage.translatesAutoresizingMaskIntoConstraints = false
        bagImage.image = UIImage(named: "LocalMall")
        //bagImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        bagImage.contentMode = .scaleAspectFit
        
        fridgeImage.translatesAutoresizingMaskIntoConstraints = false
        fridgeImage.image = UIImage(named: "KitchenFridge")
        fridgeImage.contentMode = .scaleAspectFit
    }
    
    
    func setView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        wrapperStack.addArrangedSubview(view)
        view.leadingAnchor.constraint(equalTo: wrapperStack.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: wrapperStack.trailingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: wrapperStack.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: wrapperStack.bottomAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalTo: wrapperStack.heightAnchor, multiplier: 1).isActive = true
    }
    
}
