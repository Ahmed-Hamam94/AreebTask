//
//  ApiResponse.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {

    let results: T?
}
