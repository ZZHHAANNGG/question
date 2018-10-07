//  
//  SelectAddressService.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation
import Moya

class SelectAddressService: SelectAddressServiceProtocol {
    // Call protocol function
    
    func provider<T>() -> MoyaProvider<T> where T : TargetType {
        let provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin(verbose: true)])
        
        return provider
    }
}
