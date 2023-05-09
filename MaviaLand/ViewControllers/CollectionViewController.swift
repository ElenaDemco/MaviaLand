//
//  CollectionViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class CollectionViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet var imageNFT: UIImageView!
    
    @IBOutlet var collectionName: UILabel!
    @IBOutlet var numberNFT: UILabel!
    @IBOutlet var priceNFT: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: - IBActions
    @IBAction func buttonBuyNowDidTapped() {
    }
    
}
