//
//  RDTListCell.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/21/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

class RDTListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)    }
    
    public func setData(listingData:RDTListingData) {
        thumbnailImageView.imageFromServerURL(urlString: listingData.thumbnailUrl)
        titleLabel.text = listingData.title
        hoursLabel.text = listingData.createdAt?.timeAgo()
        if let numComments = listingData.numComments {
            numberOfCommentsLabel.text = "Number of comments : \(numComments)"
        } else {
            numberOfCommentsLabel.text = ""
        }
        
        if let author = listingData.author {
            authorLabel.text = "By : \(author)"
        } else {
            authorLabel.text = ""
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
