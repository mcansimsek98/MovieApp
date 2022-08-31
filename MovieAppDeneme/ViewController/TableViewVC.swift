//
//  ViewController.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit
import Alamofire
import SDWebImage

class TableViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentControl: UISegmentedControl!
    let searchbarController = UISearchController()
    var movie = [TheMovie]()
    var searchActive = false
    var filtered : [TheMovie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms(url: "https://api.themoviedb.org/3/movie/popular?api_key=93afe4ebbd3c18090641ed4b4089cf32")
        title = "The Movie DP"
        tableView.dataSource = self
        tableView.delegate = self
        searchbarController.searchBar.delegate = self
        navigationItem.searchController = searchbarController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellVC else { fatalError("Cell is problem") }
        
        
        if searchActive {
            cell.titleLbl.text = filtered[indexPath.row].title
            cell.bodyLbl.text = filtered[indexPath.row].overview
            cell.languageLbl.text = "Languege: " + "\(filtered[indexPath.row].original_language)".uppercased()
            cell.scoreLbl.text = "Score: \(filtered[indexPath.row].vote_average)"
            let urlString = "https://image.tmdb.org/t/p/w500\(filtered[indexPath.row].poster_path)"
            let imageUrl: NSURL? = NSURL(string: urlString)
            if let imageUrl = imageUrl {
                cell.imageViewCell.sd_setImage(with: imageUrl as URL)
            }
        } else {
            cell.titleLbl.text = movie[indexPath.row].title
            cell.bodyLbl.text = movie[indexPath.row].overview
            cell.languageLbl.text = "Languege: " + "\(movie[indexPath.row].original_language)".uppercased()
            cell.scoreLbl.text = "Score: \(movie[indexPath.row].vote_average)"
            let urlString = "https://image.tmdb.org/t/p/w500\(movie[indexPath.row].poster_path)"
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
            vc.selectedTitle = movie[indexPath.row].title
            vc.selectedBody = movie[indexPath.row].overview
            vc.selectedImage = "https://image.tmdb.org/t/p/w500\(movie[indexPath.row].backdrop_path)"
            vc.selectedOriginalTitle = movie[indexPath.row].original_title
            vc.selectedPopularity = movie[indexPath.row].popularity
            vc.selectedReleaseDate = movie[indexPath.row].release_date
            vc.selectedVoteCount = movie[indexPath.row].vote_count
            vc.selectedLanguage = movie[indexPath.row].original_language
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


extension TableViewVC {

    func fetchFilms(url: String) {
        let request = AF.request(url)
        
        request.responseDecodable(of: Movies.self) { (responce) in
            guard let films = responce.value else { return }
            self.movie = films.results
            
            self.tableView.reloadData()
        }
    }

    func segmentControlFunc() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.fetchFilms(url: "https://api.themoviedb.org/3/movie/popular?api_key=93afe4ebbd3c18090641ed4b4089cf32")
            self.tableView.reloadData()
        case 1:
            self.fetchFilms(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=93afe4ebbd3c18090641ed4b4089cf32")
            self.tableView.reloadData()
        case 2:
            self.fetchFilms(url: "https://api.themoviedb.org/3/movie/upcoming?api_key=93afe4ebbd3c18090641ed4b4089cf32")
            self.tableView.reloadData()
        default:
            print("error")
        }
    }
}





