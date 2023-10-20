//
//  UITableView+Extension.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 20/10/2023.
//

import UIKit

extension UITableView {
 /// register TableViewCell Xib
    func registerCelNib<cell: UITableViewCell>(cellClass: cell.Type){
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
}
