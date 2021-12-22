//
//  NavigationController.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit

class NavigationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let signIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        if let IsLoggedIn = UserDefaults.standard.object(forKey: "IsLoggedIn"){
            if IsLoggedIn as! Bool {
                self.pushViewController(profile, animated: false)
                return
            }
        }
        if let RegDone = UserDefaults.standard.object(forKey: "RegDone") {
            if RegDone as! Bool {
                self.pushViewController(signIn, animated: false)
                return
            }
        }
    }
}
