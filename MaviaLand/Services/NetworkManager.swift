//
//  NetworkManager.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import Foundation 

enum Link {
    case ethImageURL
    case maviaLandImageURL
    case maviaLandBannerURL
    case maviaLandURL
    case webMaviaLandURL
    
    var url: URL {
        switch self {
        case .ethImageURL:
            return URL(string: "https://ethereum.org/static/a183661dd70e0e5c70689a0ec95ef0ba/13c43/eth-diamond-purple.png")!
        case .maviaLandImageURL:
            return URL(string: "https://i.seadn.io/gcs/files/af3f8275c2b4fde9aa5c964584186144.gif?w=500&auto=format")!
        case .maviaLandBannerURL:
            return URL(string: "https://i.seadn.io/gcs/files/51d38eb7fbb6c62187b580aeaf108748.jpg?w=500&auto=format")!
        case .maviaLandURL:
            return URL(string: "https://api.opensea.io/collection/mavia-land?format=json")!
        case .webMaviaLandURL:
            return URL(string: "https://mavia.com")!
        }
    }
}

enum NetworkError: Error {
    case invalidURl
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchCollection(completion: @escaping(Result<MaviaLand, NetworkError>) -> Void) {
        let url = Link.maviaLandURL.url
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let maviaLand = try decoder.decode(MaviaLand.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(maviaLand))
                    return
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

