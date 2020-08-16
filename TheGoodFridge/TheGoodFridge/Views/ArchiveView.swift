//
//  ArchiveView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/2/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

//create a function that sets and returns a UIView

class ArchiveView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createGrocerListBoxByDate(date: String, productList: [String]) -> UIView {
        let wrapperView = UIView()
        return wrapperView
    }
    
}
