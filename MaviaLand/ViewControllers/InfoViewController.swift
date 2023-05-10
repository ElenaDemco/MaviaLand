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
    
    @IBOutlet var ethRateLabel: UILabel!
    @IBOutlet var usdRateLabel: UILabel!
    @IBOutlet var statsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var logOutButton: UIButton!
    
    // MARK: - Public Properties
    let networkManager = NetworkManager.shared
    
    var collection: Collection?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.layer.cornerRadius = 8
        
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
            ethRateLabel.text = String("\(paymentToken.ethPrice)")
            usdRateLabel.text = String("\(paymentToken.usdPrice)")
        }
        statsLabel.text = String("\(info.stats)")
        descriptionLabel.text = info.description
        
        networkManager.fetchImage(from: info.imageUrl) { [weak self] result in
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
