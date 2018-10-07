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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Explore"
        navigationItem.title = "DoorDash"
        
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
    }
}


