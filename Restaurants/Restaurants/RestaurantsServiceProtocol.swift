//  
//  RestaurantsServiceProtocol.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation
import Moya

protocol RestaurantsServiceProtocol {
    // Add you own protocol function for a RestaurantsServiceProtocol.
    func provider<T>() -> MoyaProvider<T> where T:TargetType
}
