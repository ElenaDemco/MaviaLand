//
//  NFTCell.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class NFTCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var imageNFT: UIImageView!
    
    @IBOutlet var collectionName: UILabel!
    @IBOutlet var quantityNFT: UILabel!
    @IBOutlet var ownersQuantityNFT: UILabel!
    
    @IBOutlet var openButton: UIButton!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Properties
    var buttonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        openButton.layer.cornerRadius = 8
        imageNFT.layer.cornerRadius = imageNFT.frame.width / 2
    }
    
    
    // MARK: - Public Methods
    func configureCollection(with info: Collection) {
        collectionName.text = info.name
        quantityNFT.text = "Lands: \(info.stats.count)"
        ownersQuantityNFT.text = String("Owners: \(info.stats.numOwners)")
        
        networkManager.fetchImage(from: info.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageNFT.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func buttonOpenDidTapped(_sender: Any) {
        if let tableView = self.superview as? UITableView {
            if let indexPath = tableView.indexPath(for: self) {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
            }
        }
    }
}



