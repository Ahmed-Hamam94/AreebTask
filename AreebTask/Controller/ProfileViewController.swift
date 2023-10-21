//
//  ProfileViewController.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!{
        didSet {
            backgroundView.layer.shadowColor = UIColor.gray.cgColor
            backgroundView.layer.shadowOpacity = 0.5
            backgroundView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backgroundView.layer.cornerRadius = 10
            
        }
    }
    
    // MARK: -  Variables

    var date: String?
    var repository: Repository?
    var updatedAt: String?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repository?.fullName
        configureUIWithData()
    }

    // MARK: - Private Functions
    private func configureUIWithData(){
        
        guard let imageUrl = repository?.owner?.avatarUrl?.encodeUrl().asUrl else {return}
        profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        profileImageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: nil)
        profileImageView.makeCircular()
        
        ownerNameLabel.text = repository?.owner?.login
        
        guard let is_private = repository?.privateField else {return}
        if is_private {
            statusLabel.text = "Private"
        }else{
            statusLabel.text = "Public"
        }
        
        repoNameLabel.text = repository?.name
        descriptionLabel.text = "Description: \n\(repository?.description ?? "")"
        
        let formattedDate = setDate(date: date ?? "")
        createdAtLabel.text = "Created: \n\n\(formattedDate)"
        let formattedUpdatedDate = setDate(date: updatedAt ?? "")

        updatedAtLabel.text = "Updated: \n\n\(formattedUpdatedDate)"
    
    }
    
    private func setDate(date: String)-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let createdDate = dateFormatter.date(from: date){
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: createdDate, to: currentDate)
            if let days = components.day ,let months = components.month , let years = components.year {
                if months >= 6 {
                    let formattedDate = DateFormatter.localizedString(from: createdDate, dateStyle: .long, timeStyle: .none)
                    return formattedDate
                }else if months < 1 {
                    let formattedDate = "\(days) days ago"
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
