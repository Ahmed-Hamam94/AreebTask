//
//  Repository.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 19/10/2023.
//

import Foundation

struct Repository: Codable {
    
    let id: Int
    let name: String
    let fullName: String
    let privateField: Bool
    let owner: Owner
    let description: String
}

struct Owner: Codable {
    
    let login: String
    let id: Int
    let avatarUrl: String
}
