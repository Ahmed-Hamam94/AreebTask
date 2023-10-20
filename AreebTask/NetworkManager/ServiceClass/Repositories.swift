//
//  Repositories.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

protocol RepositoriesProtocol {
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>)-> Void)
}

class RepositoriesService: RepositoriesProtocol {
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) {
        
        NetworkManager.shared.request(endPoint: EndPoint.repositories, method: .Get, completion: completion)
    }
    
    
}
