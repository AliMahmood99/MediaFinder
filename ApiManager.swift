//
//  ApiManager.swift
//  AlamofireDemo
//
//  Created by ali mahmood saad on 7/7/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import Foundation
import Alamofire


class Apimanager: NSObject {
    class func loadItunesMedia(criteria: String, mediaType: String, completion: @escaping (_ error: Error?,_ media: [Media]?) -> Void) {
        let param = ["term": criteria,
                     "media": mediaType]
        
        Alamofire.request(URLs.itunes, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).response { (response) in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error,nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from api")
                print("this is data \(Data.self) ")
                //                completion("did't get any data from api" as! Error ,nil)
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mediaArr = try decoder.decode(MediaResponse.self, from: data).results
                completion(nil, mediaArr)
            } catch let eroor {
                print(eroor)
            }
        }
        
        
        
    }
}

