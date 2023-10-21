//
//  String+Extension.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import Foundation

extension String {
    var asUrl: URL?{
        return URL(string: self)
    }
    
    func encodeUrl() -> String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
