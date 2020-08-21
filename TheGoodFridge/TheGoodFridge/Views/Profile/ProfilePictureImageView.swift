//
//  CircularImageView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 8/19/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ProfilePictureImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.image = UIImage(named: "DefaultProfilePicture")
        self.contentMode = .scaleAspectFill
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }

}
