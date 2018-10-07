//  
//  RestaurantsTarget.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation
import Moya

public enum RestaurantsTarget : AutoTargetProtocol {
    // Is for Dependence Injection or Sourcery placeholder protocol
    
    case storeSearch(String, String)
}

extension RestaurantsTarget : TargetType {
    public var baseURL: URL { return target.targetRef(version: .v1, protocol: .https).baseUrl }
    
    public var para : [String : Any]{
        switch self {
        case let .storeSearch(lat, lng):
            return ["lat":lat, "lng":lng]
        }
    }
    
    public var path: String {
        switch self {
        case .storeSearch:
            return "store_search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .storeSearch:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .storeSearch:
            return .requestParameters(parameters: self.para, encoding: URLEncoding.default)
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .storeSearch:
            guard let path = Bundle.main.path(forResource: "store_search", ofType: "json"),
            let json = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return Data()
            }
            
            return json
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
