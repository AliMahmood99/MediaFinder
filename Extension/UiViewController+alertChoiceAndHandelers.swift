//
//  UiViewController+alertChoiceAndHandelers.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/8/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit

enum HandlerFunc {
    func Push(Controller :Any , navController :Any)  {
        Navigation().instantiateViewController(Controller: Controller,Action: .Push ,Navigation: navController as! UINavigationController)
    }
}

extension UIViewController {
    func alertChoice (
        title: String,
        message: String ,
        firstChoice :String ,
        handlefirstChoice : @escaping (_ action :UIAlertAction) -> Void,
        secondChoice :String ,
        handlesecondChoice : @escaping (_ action :UIAlertAction) -> Void
        ) {
        
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: firstChoice, style: .default, handler: handlefirstChoice ))
        
        refreshAlert.addAction(UIAlertAction(title: secondChoice, style: .default, handler: handlesecondChoice))
        
        present(refreshAlert,animated: true,completion: nil)
    }
    
}

