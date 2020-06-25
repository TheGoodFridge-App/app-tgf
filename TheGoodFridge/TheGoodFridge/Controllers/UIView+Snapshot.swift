//
//  UIView+Snapshot.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 6/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
    
}
