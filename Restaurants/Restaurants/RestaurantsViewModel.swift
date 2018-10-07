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
    
    private let provider:MoyaProvider<<#T#>> = RestaurantsService().provider()
    
    init() {
    }
    
}

extension RestaurantsViewModel {
    
}
