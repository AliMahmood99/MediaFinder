//
//  UIViewController+Controller.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/8/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit

enum Action {
    case Push
    case Pop
}

struct Navigation {
    
    var mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func instantiateViewController(Controller : Any ,Action : Action , Navigation :UINavigationController) {
        
        var NavigationController :UINavigationController?
        NavigationController = Navigation
        
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "\(Controller)") 
        
        if Action == .Push {
            NavigationController?.pushViewController(viewController, animated: true)
        }
        if Action == .Pop {
            NavigationController?.popViewController(animated: true)
        }
    }
    
}
