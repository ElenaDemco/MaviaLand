//
//  CollectionViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class CollectionViewController: UITableViewController {
    
    // MARK: - Private properties
    private var nft: [Collection] = []
    
    var user: UserApp?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
        
        fetchCollection()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showInfo" {
            return false
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nft.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! NFTCell
        let item = nft[indexPath.row]
        cell.configureCollection(with: item)
        cell.buttonTapped = { [weak self] in
            self?.performSegue(withIdentifier: "showInfo", sender: indexPath)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo",
           let indexPath = sender as? IndexPath {
            let destinationController = segue.destination as! InfoViewController
            destinationController.collection = nft[indexPath.row]
        }
    }
    
    // MARK: - IBActions
    @IBAction func globeTapped(_ sender: Any) {
        UIApplication.shared.open(Link.webMaviaLandURL.url)
    }
}


// MARK: - Networking
extension CollectionViewController {
    func fetchCollection() {
        URLSession.shared.dataTask(with: Link.maviaLandURL.url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(MaviaLand.self, from: data)
                self?.nft = [response.collection]
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("Decoding error: ", error)
            }
        }.resume()
    }
}

