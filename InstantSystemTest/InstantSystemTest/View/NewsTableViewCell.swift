//
//  NewsTableViewCell.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var urlImage: URL?
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage() {
        guard let url = urlImage else {
            return
        }
        photoView.load(url: url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
