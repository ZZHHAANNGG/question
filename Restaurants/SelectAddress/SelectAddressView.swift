//  
//  SelectAddressView.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class SelectAddressView: UIViewController {
    
    let heightConstraint:CGFloat = 78
    
    // OUTLETS HERE

    // VARIABLES HERE
    fileprivate var viewModel:RestaurantsViewModel!
    
    lazy var mapView:MKMapView = {
        let map = MKMapView(frame: CGRect.zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }()
    
    lazy var addressLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = theGrapColor
        
        return label
    }()
    
    lazy var confirmButton:UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm Address", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = theRedColor
        
        return button
    }()
    
    init(viewModel:RestaurantsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "Choose an Address"
        
        view.addSubview(mapView)
        view.addSubview(addressLabel)
        view.addSubview(confirmButton)
        
        createConstraints()
        
        bindUI()
    }
}


extension SelectAddressView{
    fileprivate func bindUI(){
        
    }
    
    fileprivate func createConstraints(){
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: heightConstraint),
            
            confirmButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: heightConstraint),
            confirmButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}
