//
//  Repository.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 19/10/2023.
//

import Foundation

struct Repository: Codable {

    let id: Int?
    let name: String?
    let fullName: String?
    let privateField: Bool?
    let owner: Owner?
    let description: String?
    let createdAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case privateField = "private"
        case owner = "owner"
        case description = "description"
        case createdAt = "created_at"
    }
}

struct Owner: Codable {

    let login: String?
    let id: Int?
    let avatarUrl: String?
  //  let createdAt: String?

    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
       // case createdAt = "created_at"
    }

}

struct Details: Codable {
    let createdAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
}
