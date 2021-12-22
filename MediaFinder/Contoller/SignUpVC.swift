//
//  SignUpVC.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit
import MapKit

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!

    var gender :Gender!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBaseManager.shared().setUpConnection()
    
    }
    
 
    func fieldsIsNotEmpty () -> Bool {
        
        if emailTextField.text!.isEmpty {
            alertExt(
                title: "Reqired", message: "Email is Required", style: .alert
            )
            return false
            
        }
        
        if passwordTextField.text!.isEmpty {
            alertExt(
                title: "Reqired", message: "password is Required", style: .alert
            )
            return false
        }
        if phoneNumTextField.text!.isEmpty {
            alertExt(
                title: "Reqired", message: "Phone is Required", style: .alert
            )
            return false
        }
        guard profileImageView.image != nil else {
            alertExt(
                title: "Reqired", message: "Image is Required", style: .alert
            )
            return false
        }
        if addressTextField.text!.isEmpty {
            alertExt(
                title: "Reqired", message: "address is Required", style: .alert
            )
            return false
        }
        return true
    }
    
    func isValidData () -> Bool {
        if  emailTextField.text!.isValid(.email) && passwordTextField.text!.isValid(.password) && phoneNumTextField.text!.isValid(.phone) {
            return true
        } else {
            if emailTextField.text!.isValid(.email) == false {
                alertExt(title: "Wrong Email", message: "email should be like \"Example@yahoo.com\"", style: .alert)
            } else if passwordTextField.text!.isValid(.password) == false {
                alertExt(title: "Wrong Password", message: "password should have minimum 8 char and symbols and numbers", style: .alert)
            } else if phoneNumTextField.text!.isValid(.phone) == false {
                alertExt(title: "Wrong Phone", message: "phone should be like 01012345678" , style: .alert)
            }
        }
        return false
    }

    
    @IBAction func signUPBtnpressed(_ sender: Any) {
        if fieldsIsNotEmpty() {
            if isValidData() {
                
                let user = Users ( name: nameTextField.text ?? "",
                               email: emailTextField.text!.lowercased(),
                               password: passwordTextField.text!,
                               phoneNum: phoneNumTextField.text!,
                               gender: gender ?? Gender.male ,
                               address: addressTextField.text!,
                               image: Image(withImage: profileImageView.image!))
                
                DataBaseManager.shared().insertUser(user: user)
                Navigation().instantiateViewController(Controller: SignInVC.self, Action: .Push ,Navigation: self.navigationController!)


            }
        }
        
    }
    
    

    
    @IBAction func openMapPressed(_ sender: Any) {
        let mapVC = UIStoryboard(name: storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.mapVC) as! MapVC
      
        mapVC.delegate = self
        self.present(mapVC, animated: true, completion: nil)

    }
    
    
    
    @IBAction func genderSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            gender = .male
            genderLabel.text = "Male"

        } else {
            gender = .female
            genderLabel.text = "Female"

        }
    }
    
    @IBAction func shooseImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    

        
}

extension SignUpVC: AddressDelegate {
    func sendAdress(adress: String) {
        addressTextField.text = adress
}

}



extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImageView.contentMode = .scaleAspectFit
        // Set photoImageView to display the selected image.
        profileImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
