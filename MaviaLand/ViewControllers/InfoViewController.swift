//
//  WalletViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class InfoViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var usdImage: UIImageView!
    @IBOutlet var ethImage: UIImageView!
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ethRateLabel: UILabel!
    @IBOutlet var usdRateLabel: UILabel!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
