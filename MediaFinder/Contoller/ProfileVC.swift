//
//  ProfileVC.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    var user: Users!
    
    static var checkEmail: String!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    

    
    override func viewDidLoad() {
        
        self.navigationItem.title = "Profile"
        super.viewDidLoad()

        getDataFromUser()
    
    }

    
    

    func getDataFromUser(){
        
        var email: String?
        var gender: String?
        var adress: String?
        var phoneNumber: String?
        var image: Data?
        var name: String?
        
        DataBaseManager.shared().checkUserByEmail(email: ProfileVC.checkEmail!) { (selected) in
            email = selected[DataBaseManager.shared().email]
            name = selected[DataBaseManager.shared().name]
            phoneNumber = selected[DataBaseManager.shared().phoneNum]
            adress = selected[DataBaseManager.shared().address]
            gender = selected[DataBaseManager.shared().gender]
            image = selected[DataBaseManager.shared().image]
        }
            emailLabel.text = email
            userNameLabel.text = name
            phoneLabel.text = phoneNumber
            addressLabel.text = adress
            imageLabel.image = UIImage(data: image!)
            genderLabel.text = gender
        
    }
    
    @IBAction func logoutProfile(_ sender: Any) {
        
        Navigation().instantiateViewController(Controller: SignInVC.self, Action: .Push ,Navigation: self.navigationController!)
        
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
    }
}



extension String {
    
    func stringToImage(_ handler: @escaping ((UIImage?)->())) {
        if let url = URL(string: self) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    handler(image)
                }
                }.resume()
        }
    }
}
