//
//  SignInVC.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit
import SDWebImage
class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func fieldsIsNotEmpty() -> Bool {
        
        if emailTextField.text!.isEmpty {
            alertExt(title: "Reqired", message: "Email is Required", style: .alert)
            return false
        }
        
        if passwordTextField.text!.isEmpty {
            alertExt(
                title: "Reqired", message: "password is Required", style: .alert)
            return false
        }
        return true
    }
    
    func isValidData () -> Bool {
        if  emailTextField.text!.isValid(.email) && passwordTextField.text!.isValid(.password) {
            return true
        } else {
            if emailTextField.text!.isValid(.email) == false {
                alertExt(title: "Wrong Email", message: "email should be like \"Example@yahoo.com\"", style: .alert)
            } else if passwordTextField.text!.isValid(.password) == false {
                alertExt(title: "Wrong Password", message: "password should have minimum 8 char and symbols and numbers", style: .alert)
            }
            return false
        }
    }
    
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if fieldsIsNotEmpty() {
            if isValidData() {
                let user1 = Users(email: emailTextField.text!, password: passwordTextField.text!)
           if  DataBaseManager.shared().checkSignInData(user: user1) {

            Navigation().instantiateViewController(Controller: MoviesVC.self, Action: .Push ,Navigation: self.navigationController!)

                UserDefaults.standard.set(emailTextField.text, forKey: "Email")
            } else {
                alertExt(title: "wrnog email or password", message: "please check your data again", style: .alert)
            }
            
                
            
                
            }
            
        }
        
    }

    
    @IBAction func SignUpBtnPressed(_ sender: Any) {
        
        Navigation().instantiateViewController(Controller: SignUpVC.self, Action: .Push ,Navigation: self.navigationController!)
        
    }
    
    
    }
    
    
    
    






