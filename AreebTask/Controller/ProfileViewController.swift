//
//  ProfileViewController.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var date: String?
    var repository: Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIWithData()
    }


    private func configureUIWithData(){
        
        guard let imageUrl = repository?.owner?.avatarUrl?.asUrl else {return}
        profileImageView.sd_setImage(with: imageUrl)
        profileImageView.makeCircular()
        ownerNameLabel.text = repository?.owner?.login
        guard let is_private = repository?.privateField else {return}
        if is_private {
            statusLabel.text = "Private"
        }else{
            statusLabel.text = "Public"
        }
        repoNameLabel.text = repository?.name
    }

}
