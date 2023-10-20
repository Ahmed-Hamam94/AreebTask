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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Repository, createdAt: String){
        guard let imageUrl = model.owner?.avatarUrl?.asUrl else {return}
        avatarImageView.sd_setImage(with: imageUrl)
        avatarImageView.makeCircular()
        ownerNameLabel.text = model.owner?.login
        guard let is_private = model.privateField else {return}
        guard let repoName = model.name else {return}
        if is_private {
            repositoryNameLabel.text = "\(repoName)    Private"
        }else{
            repositoryNameLabel.text = "\(repoName)    Public"
        }
        
        let formattedDate = setDate(date: createdAt)
        descriptionLabel.text = model.description
    }
    
    private func setDate(date: String)-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let createdDate = dateFormatter.date(from: date){
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .year], from: createdDate, to: currentDate)
            if let months = components.month , let years = components.year {
                if months >= 6 {
                    let formattedDate = DateFormatter.localizedString(from: createdDate, dateStyle: .long, timeStyle: .none)
                    return formattedDate
                }else {
                    let formattedDate = "\(months) months ago, \(years) years ago"
                    return formattedDate
                }
            }
        }
        return ""
    }
    
}

//4. Creation date If the date since more than 6 months use the following format Thursday, Oct
//22, 2020 else use 4 months ago, 2 years ago.
