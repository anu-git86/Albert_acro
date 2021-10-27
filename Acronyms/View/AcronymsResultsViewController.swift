//
//  AcronymsResultsViewController.swift
//  Acronyms
//
//  Created by Anusha G on 10/26/21.
//

import UIKit

class AcronymsResultsViewController: UIViewController {
    
    enum Constants {
        static let navigationTitle = "Search Acronyms"
    }
    
    @IBOutlet private weak var resultsTableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    //MARK: Private Variables
    private var viewModel: AcronymsResultsViewModel = AcronymsResultsViewModel()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = Constants.navigationTitle
        
        createSearchBar()
        viewModelDataBinding()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func viewModelDataBinding() {
        viewModel.searchResults.bind { [weak self] results in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = true
                self?.resultsTableView.isHidden = false
                self?.resultsTableView.reloadData()
            }
        }
        viewModel.errorMessage.bind { [weak self] errortext in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = false
                self?.resultsTableView.isHidden = true
                self?.errorLabel.text = errortext as? String
            }
        }
    }
        
}

//MARK: Search Controller

extension AcronymsResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        viewModel.fetchSearchResults(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resultsTableView.isHidden = true
        viewModel.searchResults.value = nil
    }
    
}

 //MARK: TableView Datasource

extension AcronymsResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let resultsCell = self.resultsTableView.dequeueReusableCell(withIdentifier: "ResultsCell") as? ResultsTableViewCell else { return UITableViewCell() }
        resultsCell.titleLabel.text = viewModel.searchResults.value?[indexPath.row].lf
        return resultsCell
    }
    
    
}
