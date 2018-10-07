//
//  Target.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation

protocol TargetBaseProtocl {
    var prefix:targetProtocl { get }
    var version:targetVersion { get }
    var withBase:String { get }
    var baseUrl:URL { get }
}

enum targetProtocl : String, RawRepresentable {
    case https = "https://", http = "http://"
}

enum targetVersion : String, RawRepresentable {
    case v1 = "v1"
}

enum target : TargetBaseProtocl {
    
    static let targetBase = "api.doordash.com"
    
    case targetRef(version:targetVersion, protocol:targetProtocl)

    var version: targetVersion {
        switch self {
        case .targetRef(let version, _):
            return version
        }
    }
    
    var prefix: targetProtocl{
        switch self {
        case .targetRef( _, let proto):
            return proto
        }
    }
    
    var withBase: String {
        switch self {
        case let .targetRef(version, `protocol`):
            return URLComponents(string: "\(`protocol`.rawValue)\(target.targetBase)/\(version.rawValue)")?.description ?? ""
        }
    }
    
    var baseUrl: URL {
        switch self {
        case let .targetRef(version, `protocol`):
            guard let url = URLComponents(string: "\(`protocol`.rawValue)\(target.targetBase)/\(version.rawValue)")?.url else {
                return URL(string: "")!
            }
            
            return url
        }
    }
}
