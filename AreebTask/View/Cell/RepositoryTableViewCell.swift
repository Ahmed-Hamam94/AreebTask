//
//  RepositoryTableViewCell.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarImageView: UIImageView! 
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Repository, createdAt: String){
        guard let imageUrl = model.owner?.avatarUrl?.encodeUrl().asUrl else {return}
        avatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        avatarImageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: nil)
        avatarImageView.makeCircular()
        ownerNameLabel.text = model.owner?.login
        guard let is_private = model.privateField else {return}
        
        guard let repoName = model.name else {return}
        repositoryNameLabel.text = repoName

        if is_private {
            statusLabel.text = "Private"
        }else{
            statusLabel.text = "Public"
        }
        
        
    }
    
  
}


