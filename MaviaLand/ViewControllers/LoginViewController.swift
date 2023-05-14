//
//  LoginViewController.swift
//  MaviaLand
//
//  Created by Yelena Demchenko on 09.05.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    @IBOutlet var maviaLandImage: UIImageView!
    
    // MARK: - Private properties
    
    private let user = UserApp.getUserData()
    private let networkManager = NetworkManager.shared
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.cornerRadius = 8
        
        userNameTF.text = user.login
        passwordTF.text = user.password
        
        fetchImage()
    }
    
    override func viewDidLayoutSubviews() {
        maviaLandImage.layer.cornerRadius = maviaLandImage.frame.width / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection",
           let collectionVC = segue.destination as? CollectionViewController {
            collectionVC.user = user
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func logInButtonTapped() {
        guard userNameTF.text == user.login && passwordTF.text == user.password else {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTF
            )
            return
        }
        performSegue(withIdentifier: "showCollection", sender: nil)
    }
    
    @IBAction func forgotRegisterData(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(title: "Hint", message: "Your name is \(user.login).")
        : showAlert(title: "Hint", message: "Your password is \(user.password).")
    } 
    
    // MARK: - Private Methods
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func fetchImage() {
        networkManager.fetchImage(from: Link.maviaLandImageURL.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.maviaLandImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}




