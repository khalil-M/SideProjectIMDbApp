//
//  SearchViewController+.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import UIKit
import IMDbApiModule

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let router: SearchViewRouter
    
    private let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Movies, Tv Shows"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    init(viewModel: SearchViewModel, router: SearchViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController

    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        resultsController.delegate = self
        
        viewModel.searchMovieBy(title: query) { results in
            DispatchQueue.main.async {
                resultsController.update(with: results)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
//              let query = searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return
//        }
//
//        resultsController.delegate = self
//
//        viewModel.searchMovieBy(title: query) { results in
//            DispatchQueue.main.async {
//                resultsController.update(with: results)
//            }
//        }
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResult(_ result: SearchResult) {
        // route to movie details
        router.routeToMovieDetails(for: result)
    }
}
