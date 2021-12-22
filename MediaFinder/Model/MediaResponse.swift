//
//  MediaResponse.swift
//  AlamofireDemoPr
//
//  Created by ali mahmood saad on 7/19/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import Foundation


struct MediaResponse: Codable {
    var resultCount: Int
    var results: [Media]
}
