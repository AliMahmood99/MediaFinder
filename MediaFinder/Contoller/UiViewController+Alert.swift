//
//  UiViewController+Alert.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/2/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit
extension UIViewController {
    func alertExt(title :String , message :String , style :UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }
}
