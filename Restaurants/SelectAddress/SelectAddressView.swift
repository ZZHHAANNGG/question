//  
//  SelectAddressView.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import UIKit
import MapKit
import Contacts
import RxSwift
import RxCocoa
import RxGesture
import RxMKMapView

class SelectAddressView: UIViewController {
    
    let heightConstraint:CGFloat = 78

    // VARIABLES HERE
    fileprivate var viewModel:RestaurantsViewModel!
    
    var selectedAnnotation = BehaviorRelay<CLLocationCoordinate2D>(value:CLLocationCoordinate2D())
    
    fileprivate var stongHolderObservable:Observable<CLLocationCoordinate2D>!
    
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
        
        confirmButton.rx.tap
            .debounce(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let `self` = self else {
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: self.rx.disposeBag)
        
        mapView.rx
            .tapGesture()
            .when(GestureRecognizerState.recognized)
            .subscribe(onNext: { [weak self](tap) in
                guard let `self` = self else {
                    return
                }
                
                let touchPoint = tap.location(in: self.mapView)
                let location = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
                
                self.selectedAnnotation.accept(location)
            })
            .disposed(by: self.rx.disposeBag)
        
            Observable.of(selectedAnnotation.asObservable(),
                          GeolocationService.instance.location.asObservable()
                            .distinctUntilChanged({
                                $0.latitude != $1.latitude || $0.longitude != $1.longitude
                            })
                )
                .throttle(0.2, scheduler: MainScheduler.instance)
                .merge()
            .subscribe( onNext: {[weak self](location) in
                guard let `self` = self else {
                    return
                }
                
                self.viewModel.latSubject.accept(String(format: "%lf", location.latitude))
                self.viewModel.lngSubject.accept(String(format: "%lf", location.longitude))
                
                self.mapView.removeAnnotations(self.mapView.annotations)
                #warning("hard code span. Need to change to enum")
                self.mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275)), animated: true)
                self.mapView.addAnnotation(MKPlacemark(coordinate: location))
                
                let geoCoder = CLGeocoder()
                
                geoCoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude), completionHandler: { (marks, error) in
                    guard let placemarks = marks, let address = placemarks.first?.postalAddress else {
                        return
                    }
                    
                    self.addressLabel.text = CNPostalAddressFormatter.string(from: address, style: .mailingAddress)
                })
        })
        .disposed(by: self.rx.disposeBag)
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
