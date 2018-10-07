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

struct RestaurantsViewModel {
    
    lazy var provider:MoyaProvider<RestaurantsTarget> = {
        let provider:MoyaProvider<RestaurantsTarget> = RestaurantsService().provider()
        
        return provider
    }()
    
    // for Dependency Injection
    init(provider:MoyaProvider<RestaurantsTarget>?) {
        if let DIProvider = provider {
            self.provider = DIProvider
        }
        
    }
    
}

extension RestaurantsViewModel {
    
}
