//
//  SearchVC.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 6.09.2022.
//

import UIKit
import RxSwift

class SearchVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var searcTableView: UITableView!
    
    let searchbarController = UISearchController()
    var searchActive = false
    var filtered : [HomeViewModel] = []
    var movieList : [HomeViewModel] = [] {
        didSet {
            self.searcTableView.reloadData()
        }
    }
    let movieListViewModel : MovieListViewModel = MovieListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        call()
        binViewModel()
        searchbarController.searchBar.delegate = self
        searchbarController.searchBar.backgroundColor = UIColor.darkGray
        searchbarController.searchBar.barTintColor = UIColor.clear
        searcTableView.tableHeaderView = searchbarController.searchBar
    }
    //
    //    let searchResults = searchbarController.searchBar.rx.text.orEmpty
    //        .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
    //        .distinctUntilChanged()
    //        .flatMap { query -> Observable<[HomeViewModel]> in
    //            if query?.isEmpty {
    //                return .just([])
    //            }else {
    //                return MovieListViewModel.searchMovies(query)
    //                    .catchAndReturn([])
    //            }
    //        }.observe(on: MainScheduler.instance)
    //
    
    func binViewModel(){
        movieListViewModel.downloadMovies()
        movieListViewModel.upcominMovieList.subscribe(onNext: { response in
            self.movieList = response
            self.movieList.sort() {
                $1.scoreLbl < $0.scoreLbl
            }
            self.movieList = self.movieListViewModel.popularMovies
            self.movieList = self.movieListViewModel.topRelatedMovies
            self.movieList = self.movieListViewModel.upcominMovies
            self.searcTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = movieList.filter({ item in
            item.title.localizedStandardContains(searchText)
        })
        searchActive = !filtered.isEmpty
        self.searcTableView.reloadData()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func call() {
        searcTableView.delegate = self
        searcTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return 0 //movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell()}
        if searchActive {
            let movie = filtered[indexPath.row]
            let urlString = movie.posterImage
            let imageUrl: NSURL? = NSURL(string: urlString)
            if let imageUrl = imageUrl {
                cell.searchImageView.sd_setImage(with: imageUrl as URL)
            }
            cell.searchTitleLbl.text = movie.title
            cell.searchBodyLbl.text = movie.bodyLbl
            cell.searchScoreLbl.text = "Vote Average: \(movie.scoreLbl)"
            cell.searchLanguageLbl.text = "Language: \(movie.language)"
            
        }else {
//            let movie = movieList[indexPath.row]
//            let urlString = movie.posterImage
//            let imageUrl: NSURL? = NSURL(string: urlString)
//            if let imageUrl = imageUrl {
//                cell.searchImageView.sd_setImage(with: imageUrl as URL)
//            }
//            cell.searchTitleLbl.text = movie.title
//            cell.searchBodyLbl.text = movie.bodyLbl
//            cell.searchScoreLbl.text = "Vote Average: \(movie.scoreLbl)"
//            cell.searchLanguageLbl.text = "Language: \(movie.language)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC {
            vc.selectedArray = movieList[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
