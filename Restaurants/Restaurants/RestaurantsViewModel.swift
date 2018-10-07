//  
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxCocoa
import Moya
import NSObject_Rx

class RestaurantsViewModel : NSObject {
    
    //MARK: - type alias
    typealias RestaurantsSubject = BehaviorRelay<Restaurants>
    typealias LocationSubject = BehaviorRelay<String>
    
    //MARK: - Input
    var latSubject:LocationSubject = LocationSubject(value: "37.771660")
    var lngSubject:LocationSubject = LocationSubject(value: "-122.387450")
    
    //MARK: - Output
    let restaurants: RestaurantsSubject = RestaurantsSubject(value: [Restaurant]())
    // UI would only need to display errors with a center way
    // ViewModel will handle all the business logic
    let errors = PublishRelay<String>()
    
    //MARK: - Variables
    fileprivate let queue = SerialDispatchQueueScheduler(internalSerialQueueName: "queryQueue")
    
    lazy var provider:MoyaProvider<RestaurantsTarget> = {
        let provider:MoyaProvider<RestaurantsTarget> = RestaurantsService().provider()
        
        return provider
    }()
    
    fileprivate var stongHolderObservable:Observable<Void>!
    
    // for Dependency Injection
    init(provider:MoyaProvider<RestaurantsTarget>?) {
        if let DIProvider = provider {
            self.provider = DIProvider
        }
        
        stongHolderObservable = Observable.combineLatest(latSubject, lngSubject){ (lat, lng) in
            return (lat, lng)
        }
        .observeOn(queue)
        .flatMap{ (arg) -> Observable<TargetType> in
            let (lat, lng) = arg
            
            return Observable.just(RestaurantsTarget.storeSearch(lat, lng))
        }.flatMap{[weak self](target) -> Observable<Void> in
            guard let `self` = self else {
                return Observable.just(Void())
            }
            
            self.provider.rx.request(target as! RestaurantsTarget)
            .subscribe{ event in
                switch event {
                case .success(let response):
                    var baseModel:Restaurants?
                    
                    do{
                        let decoder = JSONDecoder()
                        baseModel = try decoder.decode(Restaurants.self, from: response.data)
                    }catch let error  {
                        // this should never happen
                        self.errors.accept(error.localizedDescription)
                    }
                    
                    guard let jsonModel = baseModel else {
                        return
                    }
                    
                    self.restaurants.accept(jsonModel)
                    
                case .error(let error):
                    let errorMessage:String = error.localizedDescription
                    
                    switch error {
                    case let MoyaError.underlying(err, response):
                        switch(response?.statusCode ?? 500){
                        case 401...500:
                            self.errors.accept(err.localizedDescription)
                        default:
                            self.errors.accept(errorMessage)
                        }
                    default:
                        self.errors.accept(errorMessage)
                    }
                }
                }.disposed(by: self.rx.disposeBag)
            
            return Observable.just(Void())
        }
        
        stongHolderObservable.subscribe(onNext:{ _ in}).disposed(by: self.rx.disposeBag)
    }
    
}

extension RestaurantsViewModel {
    
}
