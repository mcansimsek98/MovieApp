//
//  ViewController.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit
import SDWebImage

class TableViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    let networkManager = NetworkManager()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentControl: UISegmentedControl!
    let searchbarController = UISearchController()
    var movie = [TheMovie]()
    var searchActive = false
    var filtered : [TheMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getData()
        }
        title = "The Movie DP"
        tableView.dataSource = self
        tableView.delegate = self
        searchbarController.searchBar.delegate = self
        navigationItem.searchController = searchbarController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellVC else { fatalError("Cell is problem") }

        if searchActive {
            let filterMovie = filtered[indexPath.row]
            cell.titleLbl.text = filterMovie.title
            cell.bodyLbl.text = filterMovie.overview
            cell.languageLbl.text = "Languege: " + "\(filterMovie.original_language)".uppercased()
            cell.scoreLbl.text = "Score: \(filterMovie.vote_average)"
            let urlString = "https://image.tmdb.org/t/p/w500\(filterMovie.poster_path)"
            let imageUrl: NSURL? = NSURL(string: urlString)
            if let imageUrl = imageUrl {
                cell.imageViewCell.sd_setImage(with: imageUrl as URL)
            }
        } else {
            let movie = movie[indexPath.row]
            cell.titleLbl.text = movie.title
            cell.bodyLbl.text = movie.overview
            cell.languageLbl.text = "Languege: " + "\(movie.original_language)".uppercased()
            cell.scoreLbl.text = "Score: \(movie.vote_average)"
            let urlString = "https://image.tmdb.org/t/p/w500\(movie.poster_path)"
            let imageUrl: NSURL? = NSURL(string: urlString)
            if let imageUrl = imageUrl {
                cell.imageViewCell.sd_setImage(with: imageUrl as URL)
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return movie.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC {
            vc.selectedArray = movie[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func indexChanged(_ sender: Any) {
        segmentControlFunc()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = movie.filter({ item in
            item.title.localizedStandardContains(searchText)
        })
        searchActive = !filtered.isEmpty
        self.tableView.reloadData()
    }

}







