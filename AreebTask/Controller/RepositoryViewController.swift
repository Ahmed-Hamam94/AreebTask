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
    
    // MARK: - Private Variables
    private var repositoriesArray = [Repository]()
    private var repositoryService: RepositoriesProtocol?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryService = RepositoriesService()
        setUpTableView()
        getRepositories()
    }

    // MARK: - Private Functions
    private func setUpTableView(){
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.registerCelNib(cellClass: RepositoryTableViewCell.self)
    }
   
    private func getRepositories(){
        
        repositoryService?.fetchRepositories(completion: { [weak self] result in
            guard let self else {return}

            switch result {

            case .success(let repositories):
                self.repositoriesArray = repositories
                DispatchQueue.main.async { [weak self] in
                    self?.repositoriesTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
//        NetworkManager.shared.getRepositoryy { [weak self] result  in
//            guard let self else {return}
//            switch result {
//
//                   case .success(let repositories):
//                       self.repositoriesArray = repositories
//                       DispatchQueue.main.async { [weak self] in
//                           self?.repositoriesTableView.reloadData()
//                       }
//                   case .failure(let error):
//                       print(error.localizedDescription)
//                   }
//        }
    }
}

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell()}
        let repository = repositoriesArray[indexPath.row]
        cell.textLabel?.text = repository.name
        return cell
    }
    
    
    
}
