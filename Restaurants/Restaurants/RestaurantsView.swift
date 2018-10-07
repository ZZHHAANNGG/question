//  
//  RestaurantsView.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxOptional
import RxSwift
import RxCocoa

class RestaurantsView: UIViewController {

    // OUTLETS HERE

    // VARIABLES HERE
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tv.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.ReuseIdentifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 50
        tv.rowHeight = UITableView.automaticDimension
        tv.tableFooterView = UIView(frame: CGRect.zero)
        return tv
    }()
    
    lazy var viewModel:RestaurantsViewModel = {
        let vm = RestaurantsViewModel()
        // init
        return vm
    }()
    
    lazy var tabItem:UITabBarItem = {
        let tabbarItem = UITabBarItem(title: "Explore", image: #imageLiteral(resourceName: "tab-explore"), selectedImage: #imageLiteral(resourceName: "tab-explore"))
        return tabbarItem
    }()
    
    lazy var leftBarItem:UIBarButtonItem = {
        let barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "nav-address"), style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        return barItem
    }()
    
    fileprivate func setupNavigationBar() {
        title = "Explore"
        navigationItem.title = "DoorDash"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:theRedColor]
        
        tabBarItem = tabItem
        
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        bindUI()

        view.addSubview(tableView)
        
        createConstraints()
    }
    
    fileprivate func createConstraints(){
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension RestaurantsView{
    
    fileprivate func bindUI(){
        viewModel.restaurants.bind(to: self.tableView.rx.items(cellIdentifier: RestaurantCell.ReuseIdentifier, cellType: RestaurantCell.self)){ _, element, cell in
            cell.driveUI(model: element)
            }.disposed(by: self.rx.disposeBag)
        
        #warning("Pass viewmodel to sub viewcontroller. Should use Dependence Injection ")
        leftBarItem.rx.tap.subscribe { [weak self](_) in
            
            guard let `self` = self else{
                return
            }
            
            let selectAddressViewController = SelectAddressView(viewModel: self.viewModel)
            
            let navigationController = UINavigationController(rootViewController: selectAddressViewController)
            
            self.present(navigationController, animated: true, completion: nil)
            
            }.disposed(by: self.rx.disposeBag)
    }
}


