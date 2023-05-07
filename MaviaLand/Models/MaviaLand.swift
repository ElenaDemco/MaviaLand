//
//  MaviaLand.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

struct MaviaLand: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let name: String
    let description: String
    let external_url: String
    
    let traits: Traits
    let payment_tokens: [Payment]
    let stats: Stats
    
    var information: String {
        return """
        Name: \(name)
        Description: \(description)
        External Link: \(external_url)
        Trats: \(traits)
        Payment Token: \(payment_tokens)
        Stats: \(String(format: "%.2f", stats.average_price)),
        Floor Price: \(String(format: "%.2f", stats.floor_price)),
        Total Sales: \(stats.total_sales)
        """
    }
}

struct Payment: Decodable {
    let id: Int
    let symbol: String
    let image_url: String
    let name: String
    
    let eth_price: Double
    let usd_price: Double
}


struct Traits: Decodable {
    let price: TraitInfo
    let type: TraitType
}

struct TraitInfo: Decodable {
    let min: Double
    let max: Double
}

struct TraitType: Decodable {
    let legendary: Int
    let common: Int
    let rare: Int
}

struct Stats: Decodable {
    let total_sales: Int
    let average_price: Double
    let floor_price: Double
}





//struct MaviaLand: Codable {
//    let collection: Collection
//}
//
//struct Collection: Codable {
//    let name: String
//    let description: String
//    let externalLink: String
//
//    let traits: Traits
//    let paymentTokens: [Payment]
//    let stats: Stats
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case description
//        case externalUrl = "external_url"
//
//        case traits
//        case paymentTokens = "payment_tokens"
//        case stats
//    }
//
//    var information: String {
//        return """
//        Name: \(name)
//        Description: \(description)
//        External Link: \(externalUrl)
//        Trats: \(traits)
//        Payment Token: \(paymentTokens)
//        Stats: \(String(format: "%.2f", stats.averagePrice)),
//        Floor Price: \(String(format: "%.2f", stats.floorPrice)),
//        Total Sales: \(stats.totalSales)
//        """
//    }
//}
//
//struct Payment: Codable {
//    let id: Int
//    let symbol: String
//    let imageUrl: String
//    let name: String
//
//    let ethPrice: Double
//    let usdPrice: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case symbol
//        case imageUrl = "image_url"
//        case name
//
//        case ethPrice = "eth_price"
//        case usdPrice = "usd_price"
//    }
//}
//
//struct Traits: Codable {
//    let price: TraitInfo
//    let type: TraitType
//
//    enum CodingKeys: String, CodingKey {
//        case price
//        case type
//    }
//}
//
//struct TraitInfo: Codable {
//    let min: Double
//    let max: Double
//}
//
//struct TraitType: Codable {
//    let legendary: Int
//    let common: Int
//    let rare: Int
//}
//
//struct Stats: Codable {
//    let totalSales: Int
//    let averagePrice: Double
//    let floorPrice: Double
//
//    enum CodingKeys: String, CodingKey {
//        case totalSales = "total_sales"
//        case averagePrice = "average_price"
//        case floorPrice = "floor_price"
//    }
//}

