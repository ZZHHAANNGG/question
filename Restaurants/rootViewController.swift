//
//  rootViewController.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import UIKit

class RootViewControoler : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        setTabBarItems()
    }
    
    func setTabBarItems(){
        
        let exploreViewController = RestaurantsView()
        
        let favoriateViewController = UIViewController()
        favoriateViewController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "tab-star"), selectedImage: #imageLiteral(resourceName: "tab-star"))
        
        favoriateViewController.navigationItem.title = "Favorites"

        let viewControllers = [
            exploreViewController, favoriateViewController
        ].map { UINavigationController(rootViewController: $0) }
        
        self.viewControllers = viewControllers
    }
}
