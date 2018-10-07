//  
//  SelectAddressTarget.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation
import Moya

public enum SelectAddressTarget {
    
}

extension SelectAddressTarget : TargetType {
    public var baseURL: URL { return URL(string: <#baseURL#>)! }
    
    public var para : [String : Any]{
        switch self {
        case <#API#>:
            return <#Method#>
        default:
            return [:]
        }
    }
    
    public var path: String {
        switch self {
        case <#API#>:
            return <#url#>
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case <#API#>:
            return <#Method#>
        }
    }
    
    public var task: Task {
        switch self {
        case let <#API#>(data):
            return <#Encoding#>
        }
    }
    
    public var sampleData: Data {
        switch self {
        case <#API#>:
            return <#StubData#>
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
