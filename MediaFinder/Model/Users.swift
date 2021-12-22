//
//  User.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//


import UIKit


enum Gender :String ,Codable{
    case male
    case female
}

struct Users : Codable {
    var name: String?
    var email: String!
    var password: String!
    var phoneNum: String?
    var gender: Gender?
    var address :String!
    var image: Image?
    
    init(name: String, email: String, password: String, phoneNum: String, gender: Gender, address: String, image: Image) {
        self.email = email
        self.password = password
        self.name = name
        self.phoneNum = phoneNum
        self.gender = gender
        self.address = address
        self.image = image
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct Image: Codable{
    let imageData: Data?

    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)

        return image
    }
    

}
