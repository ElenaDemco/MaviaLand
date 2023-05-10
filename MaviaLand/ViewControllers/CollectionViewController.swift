//
//  CollectionViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class CollectionViewController: UITableViewController {
    
    // MARK: - Private properties
    private var items: [Collection] = []
    
    var user: UserApp?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCollection()
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! NFTCell
        let item = items[indexPath.row]
        cell.configureCollection(with: item)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let infoVC = segue.destination as! InfoViewController
                infoVC.collection = items[indexPath.row]
            }
        }
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
                self?.items = [response.collection]
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                } 
            } catch {
                print("Decoding error: ", error)
            }
        }.resume()
    }
}

