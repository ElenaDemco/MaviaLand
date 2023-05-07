//
//  MaviaLand.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

struct MaviaLand: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let name: String
    let slug: String
    let description: String
    let externalLink: String
    
    let traits: [String: TraitInfo]
    let paymentTokens: [Payment]
    let stats: Stats
    
    enum CodingKeys: String, CodingKey {
        case name
        case slug
        case description
        case externalLink = "external_url"
        case traits
        case paymentTokens = "payment_tokens"
        case stats
    }
}

struct Payment: Codable {
    let id: Int
    let symbol: String
    let imageUrl: String
    let name: String
    let ethPrice: Double
    let usdPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case imageUrl = "image_url"
        case name
        case ethPrice = "eth_price"
        case usdPrice = "usd_price"
    }
}

struct Traits: Codable {
    let legendary: TraitInfo
    let common: TraitInfo
    let rare: TraitInfo
    let min: TraitInfo
    let max: TraitInfo
    
    enum CodingKeys: String, CodingKey {
        case legendary
        case common
        case rare
        case min
        case max
    }
}

struct TraitInfo: Codable {
    let min: Double?
    let max: Double?
}

struct Stats: Codable {
    let totalSales: Double
    let averagePrice: Double
    let floorPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case totalSales = "total_sales"
        case averagePrice = "average_price"
        case floorPrice = "floor_price"
    }
}

