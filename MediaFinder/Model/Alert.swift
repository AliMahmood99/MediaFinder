//
//  Alert.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func presentAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
