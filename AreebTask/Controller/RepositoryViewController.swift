//
//  RepositoryViewController.swift
//  AreebTask
//
//  Created by Ahmed Hamam on 19/10/2023.
//

import UIKit
import KRProgressHUD

class RepositoryViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    // MARK: - Private Variables
    private lazy var repositoriesArray = [Repository]()
    private var repositoryService: RepositoriesProtocol?
    private var repositoryDateService: RepositoryDateProtocol?
    private var full_name: String?
    private var date: String?
    private var updatedAt: String?
    private lazy var repoPages = 10
    private lazy var limit = 10
    private lazy var paginationRepoArray = [Repository]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        repositoryService = RepositoriesService()
        repositoryDateService = RepositoryDateService()
        setUpUI()
        getRepositories()
      
        
    }


    // MARK: - Private Functions
    private func setUpUI(){
        title = "List"
        navigationController?.navigationBar.tintColor = .label
        setUpTableView()
    }
    
    private func setUpTableView(){
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.registerCelNib(cellClass: RepositoryTableViewCell.self)
    }
    
    private func setPaginationRepo(repoPages: Int){
        
        if repoPages >= limit {
            return
        }else if repoPages >= limit - 10 {
            
            for num in repoPages..<limit {
                
                paginationRepoArray.append(repositoriesArray[num])
            }
            self.repoPages += 10
        }else {
            for num in repoPages..<repoPages + 10 {
                
                paginationRepoArray.append(repositoriesArray[num])
            }
            self.repoPages += 10
        }
        DispatchQueue.main.async { [weak self] in
            
            self?.repositoriesTableView.reloadData()
        }
    }
   
    }

// MARK: - UITableViewDelegate && DataSource
extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationRepoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell()}
        let repository = paginationRepoArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
 
        cell.configure(with: repository, createdAt: date ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repository = paginationRepoArray[indexPath.row]
        guard let fullName = repository.fullName else {return}
       // print("selected \(fullName)")
        getRepoDate(fullName: fullName )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [weak self] in
            let vc = ProfileViewController()
            vc.date = self?.date
            vc.repository = repository
            vc.updatedAt = self?.updatedAt
            self?.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == repositoriesTableView {
            
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
             
                setPaginationRepo(repoPages: repoPages)
            }
        }
    }
    

}

// MARK: - Api
extension RepositoryViewController {
 
    
     private func getRepositories(){
         KRProgressHUD.show()
         repositoryService?.fetchRepositories(completion: { [weak self] result in
             guard let self else {return}
             
             switch result {
                 
             case .success(let repositoriesArray):
                 self.repositoriesArray = repositoriesArray
                 self.limit = self.repositoriesArray.count
                 for num in 0..<10 {
                     self.paginationRepoArray.append(repositoriesArray[num])
                 }
                 
                 DispatchQueue.main.async { [weak self] in
                     self?.repositoriesTableView.reloadData()
                     KRProgressHUD.dismiss()
                 }
             case .failure(let error):
                 print(error.localizedDescription)
             }
         })
     }
     private func getRepoDate(fullName: String){
            
             repositoryDateService?.fetchRepositories(fullName: fullName, completion: { [weak self] result in
                 guard let self else {return}
                 
                 switch result {

                 case .success(let repository):
                     if let createdAt = repository.createdAt{
                         self.date = createdAt
                        
                     }
                     self.updatedAt = repository.updatedAt


                 case .failure(let error):
                     print(error.localizedDescription)
                 }
                 
             })
         }

}
