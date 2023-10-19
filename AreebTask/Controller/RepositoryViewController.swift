//
//  RepositoryViewController.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 19/10/2023.
//

import UIKit

class RepositoryViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }

    // MARK: - Private Functions
    private func setUpTableView(){
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.register(, forCellReuseIdentifier: )
    }
   

}

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
}
