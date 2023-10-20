//
//  EndPoint.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

enum EndPoint {
    
    static let base_url = "https://api.github.com/"
   //https://api.github.com/users/mojombo
    
    case repositories
    case repos(String)
    

    var path: String{
        switch self{
        case .repositories:
            return "repositories"
            
        case .repos(let full_name):
            return "repos/\(full_name)"
       
        }

    }
}
