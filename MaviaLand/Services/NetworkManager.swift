//
//  NetworkManager.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import Foundation 

enum Link {
    case maviaLandImageURL
    case maviaLandBannerURL
    case maviaLandURL
    case ethImageUrl
    
    var url: URL {
        switch self {
        case .maviaLandImageURL:
            return URL(string: "https://i.seadn.io/gcs/files/af3f8275c2b4fde9aa5c964584186144.gif?w=500&auto=format")!
        case .maviaLandBannerURL:
            return URL(string: "https://i.seadn.io/gcs/files/51d38eb7fbb6c62187b580aeaf108748.jpg?w=500&auto=format")!
        case .maviaLandURL:
            return URL(string: "https://api.opensea.io/collection/mavia-land?format=json")!
        case .ethImageUrl:
            return URL(string: "https://openseauserdata.com/files/6f8e2979d428180222796ff4a33ab929.svg")!
        }
    }
}

enum NetworkError: Error {
    case invalidURl
    case noData
    case decodingError
    case badURL
    case requestFailed
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
                return
            }
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let maviaLand = try? decoder.decode(MaviaLand.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(maviaLand))
        }.resume()
    }
}

