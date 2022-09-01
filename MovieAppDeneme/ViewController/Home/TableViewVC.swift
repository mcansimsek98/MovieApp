//
//  ViewController.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit


class TableViewVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    let searchbarController = UISearchController()
    var searchActive = false
    var filtered : [HomeViewModel] = []
    var movieListViewModel : MovieListViewModel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callViewDidload()
    }
    
    func callViewDidload() {
        self.movieListViewModel = MovieListViewModel()
        self.movieListViewModel.downloadMovies(tableView: tableView)
        title = "The Movie DP"
        tableView.dataSource = self
        tableView.delegate = self
        searchbarController.searchBar.delegate = self
        navigationItem.searchController = searchbarController
    }

    @IBAction func indexChanged(_ sender: Any) {
        segmentControlFunc()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = movieListViewModel.movieList.filter({ item in
            item.title.localizedStandardContains(searchText)
        })
        searchActive = !filtered.isEmpty
        self.tableView.reloadData()
    }
    
}
