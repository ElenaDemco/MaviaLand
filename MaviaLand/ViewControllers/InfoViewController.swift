//
//  WalletViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var bannerMaviaLand: UIImageView!
    @IBOutlet var ethImage: UIImageView!
    
    @IBOutlet var ethUsdRateLabel: UILabel!
    
    @IBOutlet var salesLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var floorLabel: UILabel!
    
    @IBOutlet var landCount: UILabel!
    
    @IBOutlet var legendaryLabel: UILabel!
    @IBOutlet var commonLabel: UILabel!
    @IBOutlet var rareLabel: UILabel!
    
    @IBOutlet var descriptionText: UITextView!
    
    @IBOutlet var logOutButton: UIButton!
    
    // MARK: - Public Properties
    let networkManager = NetworkManager.shared
    
    var collection: Collection?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.layer.cornerRadius = 8
        ethImage.layer.cornerRadius = ethImage.frame.width / 2
        
        if let collection = collection {
            configureInfo(with: collection)
        } else {
            showAlert(title: "Error", message: "Data is not available")
        }
        
        fetchImage()
    }
    
    // MARK: - IBActions
    @IBAction func LogOutButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func configureInfo(with info: Collection) {
        if let paymentToken = info.paymentTokens.first {
            ethUsdRateLabel.text = String("$\(paymentToken.usdPrice)")
        }
        
        salesLabel.text = String("Sales \n \(info.stats.totalSales)")
        averageLabel.text = String(format: "Average \n %.2f", info.stats.averagePrice)
        floorLabel.text = String(format: "Floor \n %.2f", info.stats.floorPrice)
        
        landCount.text = String("Mavia Land - \(info.stats.count) NFT")
        legendaryLabel.text = String("Legendary \n \(info.traits.type.legendary)")
        commonLabel.text = String("Common \n \(info.traits.type.common)")
        rareLabel.text = String("Rare \n \(info.traits.type.rare)")
        
        descriptionText.text = info.description
        
        networkManager.fetchImage(from: Link.ethImageURL.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.ethImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage() {
        if let collection = collection {
            networkManager.fetchImage(from: collection.bannerImageUrl) { [weak self] result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        self?.bannerMaviaLand.image = UIImage(data: imageData)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
