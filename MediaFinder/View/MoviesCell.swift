//
//  MoviesCell.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/27/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(media: Media) {
        
        self.firstLabel.text = media.artistName
        self.secondLabel.text = media.trackName
    }
    
}
