//
//  ViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 07.05.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToken()
    }
}

// MARK: - Networking
private extension MainViewController {
    func fetchToken() {
        URLSession.shared.dataTask(with: URL(string: "https://api.opensea.io/collection/mavia-land?format=json")!) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "Error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let maviaLand = try decoder.decode(MaviaLand.self, from: data)
                print(maviaLand.collection.information)
            } catch {
                print(error)
            }
        }.resume()
    }
}

