//
//  AthleteTableViewCell.swift
//  KitmanLabs
//

import UIKit

class AthleteTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoCircle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        thumbnail.image = nil
    }
    
    func configure(firstName: String, lastName: String, url: String) {
        let name = firstName + " " + lastName
        self.nameLabel.text = name
        
        self.thumbnail.downloadImage(from: url)
    }
}
