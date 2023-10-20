//
//  UIImageView+Extension.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import UIKit

extension UIImageView {
    
    func makeCircular(){
        self.layer.cornerRadius = self.frame.width/2

    }
}
