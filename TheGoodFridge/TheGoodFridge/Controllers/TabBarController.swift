//
//  TabBarController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class TabBarController: UITabBarController {

    let selectedColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
    let unselectedColor = UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.clipsToBounds = true

        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = unselectedColor
        
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        
        let groceryItem = UITabBarItem()
        groceryItem.selectedImage = UIImage(named: "GroceryIconSelected")
        groceryItem.image = UIImage(named: "GroceryIconUnselected")
        groceryItem.title = "List"
//        let searchItem = UITabBarItem()
//        searchItem.selectedImage = UIImage(named: "SearchIconSelected")
//        searchItem.image = UIImage(named: "SearchIconUnselected")
//        searchItem.title = "Search"
        let profileItem = UITabBarItem()
        profileItem.selectedImage = UIImage(named: "ProfileconSelected")
        profileItem.image = UIImage(named: "ProfileIconUnselected")
        profileItem.title = "Profile"
        
        [groceryItem, profileItem].forEach { item in
            item.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: selectedColor,
                NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!
            ], for: .selected)
            item.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: unselectedColor,
                NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!
            ], for: .normal)
        }
        
        let groceryVC = GroceryViewController()
        groceryVC.tabBarItem = groceryItem
//        let searchVC = SearchViewController()
//        searchVC.tabBarItem = searchItem
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = profileItem
        
        self.viewControllers = [groceryVC, profileVC]
        self.selectedViewController = groceryVC
    }

}
