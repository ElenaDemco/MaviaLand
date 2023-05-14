//
//  MaviaLand.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

import Foundation

struct MaviaLand: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let name: String
    let description: String
    
    let externalUrl: String
    
    let bannerImageUrl: URL
    let imageUrl: URL
    
    let traits: Traits
    let paymentTokens: [Payment]
    let stats: Stats
}
 
struct Payment: Decodable {
    let usdPrice: Double
} 


struct Traits: Decodable {
    let type: TraitType
}

struct TraitType: Decodable {
    let legendary: Int
    let common: Int
    let rare: Int
}

struct Stats: Decodable {
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
