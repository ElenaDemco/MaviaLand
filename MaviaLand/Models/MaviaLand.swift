//
//  MaviaLand.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

struct MaviaLand: Codable {
    let name: String
    let symbol: String
    let description: String
    let externalLink: String
    
    let traits: [Traits]
    let paymentTokens: [Payment]
    let stats: Stats
    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case symbol
//        case description
//        case externalLink = "external_url"
//        case traits
//        case paymentTokens = "payment_tokens"
//        case stats
//    }
}

struct Payment: Codable {
    let id: Int
    let symbol: String
    let imageUrl: String
    let name: String
    let ethPrice: String
    let usdPrice: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case symbol
//        case imageUrl = "image_url"
//        case name
//        case ethPrice = "eth_price"
//        case usdPrice = "usd_price"
//    }
}

struct Traits: Codable {
    let traitType: String
    let min: Double?
    let max: Double?
    
//    enum CodingKeys: String, CodingKey {
//        case traitType = "trait_type"
//        case min
//        case max
//    }
}

struct Stats: Codable {
    let totalSales: Double
    let averagePrice: Double
    let floorPrice: Double
    
//    enum CodingKeys: String, CodingKey {
//        case totalSales = "total_sales"
//        case averagePrice = "average_price"
//        case floorPrice = "floor_price"
//    }
}

