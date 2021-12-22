//
//  Media.swift
//  AlamofireDemoPr
//
//  Created by ali mahmood saad on 7/19/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import Foundation

struct Media: Codable {
    var artistName: String
    var trackName: String
    var artworkUrl100: String
    var longDescription: String?
    var previewUrl: String
}
