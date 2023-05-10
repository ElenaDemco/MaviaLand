//
//  MaviaLand.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

import Foundation

struct MaviaLand: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let name: String
    let description: String
    
    let externalUrl: String
    
    let bannerImageUrl: URL
    let imageUrl: URL
    
    let traits: Traits
    let paymentTokens: [Payment]
    let stats: Stats
}
 
struct Payment: Codable {
    let id: Int
    let symbol: String
    let name: String
  
    let imageUrl: URL

    let ethPrice: Double
    let usdPrice: Double
}


struct Traits: Codable {
    let price: TraitInfo
    let type: TraitType
}

struct TraitInfo: Codable {
    let min: Double
    let max: Double
}

struct TraitType: Codable {
    let legendary: Int
    let common: Int
    let rare: Int
}

struct Stats: Codable {
    let totalSales: Int
    let averagePrice: Double
    let floorPrice: Double
    let count: Int
    let numOwners: Int
}

struct UserApp {
    let login: String
    let password: String
    
    static func getUserData() -> UserApp {
        UserApp(login: "User", password: "111")
    }
}
