//
//  EndPoint.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

enum EndPoint {
    
    static let base_url = "https://api.github.com/"
   
    
    case repositories
 
    

    var path: String{
        switch self{
        case .repositories:
            return "repositories"
       
        }

    }
}
