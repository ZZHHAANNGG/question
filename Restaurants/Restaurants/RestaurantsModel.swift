//  
//  RestaurantsModel.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import Foundation

typealias Restaurants = [Restaurant]

struct Restaurant: Codable {
    let isTimeSurging: Bool?
    let maxOrderSize: Int?
    let deliveryFee, maxCompositeScore, id: Int?
    let averageRating: Double?
    let menus: [Menu]?
    let compositeScore: Int?
    let statusType: StatusType?
    let isOnlyCatering: Bool?
    let status: String?
    let numberOfRatings: Int?
    let description: String?
    let business: Business?
    let tags: [String]?
    let asapTime, extraSosDeliveryFee: Int?
    let coverImgURL: String?
    let headerImgURL: String?
    let address: Address?
    let priceRange: Int?
    let slug, name: String?
    let isNewlyAdded: Bool?
    let url: String?
    let serviceRate: Int?
    let promotion, featuredCategoryDescription: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case isTimeSurging = "is_time_surging"
        case maxOrderSize = "max_order_size"
        case deliveryFee = "delivery_fee"
        case maxCompositeScore = "max_composite_score"
        case id
        case averageRating = "average_rating"
        case menus
        case compositeScore = "composite_score"
        case statusType = "status_type"
        case isOnlyCatering = "is_only_catering"
        case status
        case numberOfRatings = "number_of_ratings"
        case description, business, tags
        case asapTime = "asap_time"
        case extraSosDeliveryFee = "extra_sos_delivery_fee"
        case coverImgURL = "cover_img_url"
        case headerImgURL = "header_img_url"
        case address
        case priceRange = "price_range"
        case slug, name
        case isNewlyAdded = "is_newly_added"
        case url
        case serviceRate = "service_rate"
        case promotion
        case featuredCategoryDescription = "featured_category_description"
    }
}

struct Address: Codable {
    let city: String?
    let state: State?
    let street: String?
    let lat, lng: Double?
    let printableAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case city, state, street, lat, lng
        case printableAddress = "printable_address"
    }
}

enum State: String, Codable {
    case ca = "CA"
}

struct Business: Codable {
    let id: Int?
    let name: String?
}

struct Menu: Codable {
    let popularItems: [PopularItem]?
    let isCatering: Bool?
    let subtitle: String?
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case popularItems = "popular_items"
        case isCatering = "is_catering"
        case subtitle, id, name
    }
}

struct PopularItem: Codable {
    let price: Int?
    let description: String?
    let imgURL: String?
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case price, description
        case imgURL = "img_url"
        case id, name
    }
}

struct MerchantPromotion: Codable {
    let minimumSubtotalMonetaryFields: MonetaryFields?
    let deliveryFee: Int?
    let deliveryFeeMonetaryFields: MonetaryFields?
    let minimumSubtotal: Int?
    let newStoreCustomersOnly: Bool?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case minimumSubtotalMonetaryFields = "minimum_subtotal_monetary_fields"
        case deliveryFee = "delivery_fee"
        case deliveryFeeMonetaryFields = "delivery_fee_monetary_fields"
        case minimumSubtotal = "minimum_subtotal"
        case newStoreCustomersOnly = "new_store_customers_only"
        case id
    }
}

struct MonetaryFields: Codable {
    let currency: Currency?
    let displayString: DisplayString?
    let unitAmount: Int?
    let decimalPlaces: Int?
    
    enum CodingKeys: String, CodingKey {
        case currency
        case displayString = "display_string"
        case unitAmount = "unit_amount"
        case decimalPlaces = "decimal_places"
    }
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum DisplayString: String, Codable {
    case the000 = "$0.00"
    case the1500 = "$15.00"
    case the3500 = "$35.00"
}

enum StatusType: String, Codable {
    case statusTypeOpen = "open"
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
