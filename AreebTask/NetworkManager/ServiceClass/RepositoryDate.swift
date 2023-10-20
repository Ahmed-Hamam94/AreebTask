//
//  RepositoryDateProtocol.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

protocol RepositoryDateProtocol {
    
    func fetchRepositories(fullName: String ,completion: @escaping (Result<Repository, APIError>)-> Void)
}

class RepositoryDateService: RepositoryDateProtocol {
    
    func fetchRepositories(fullName: String, completion: @escaping (Result<Repository, APIError>) -> Void) {
        
        NetworkManager.shared.request(endPoint: EndPoint.repos(fullName), method: .Get, completion: completion)
    }
    
    
}
