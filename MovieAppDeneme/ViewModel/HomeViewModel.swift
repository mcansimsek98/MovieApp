//
//  HomeViewModel.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 1.09.2022.
//

import UIKit

// MARK: MovieListModel

class MovieListViewModel : ObservableObject {
    @Published var movieList = [HomeViewModel]()
    let networkManager  = NetworkManager()
    
    func downloadMovies (tableView : UITableView) {
       networkManager.fetchPopularMovies(completion: { [weak self] result in
           switch result {
           case .success(let popular):
               self?.movieList = popular.results.map(HomeViewModel.init)
               tableView.reloadData()
           case .failure(let error):
               print(error.localizedDescription)
           }
       })
    }
    func downloadTopRelated (tableView : UITableView) {
        networkManager.fetchTopRelatedMovies(completion: { [weak self] result in
           switch result {
           case .success(let popular):
               self?.movieList = popular.results.map(HomeViewModel.init)
               tableView.reloadData()
           case .failure(let error):
               print(error.localizedDescription)
           }
       })
    }
    func downloadUpcomming (tableView : UITableView) {
       networkManager.fetchUpcommingMovies(completion: { [weak self] result in
           switch result {
           case .success(let popular):
               self?.movieList = popular.results.map(HomeViewModel.init)
               tableView.reloadData()
           case .failure(let error):
               print(error.localizedDescription)
           }
       })
    }
    
}

// MARK: HomeViewModel

struct HomeViewModel {
    let movie : TheMovie
    
    var title : String {
        movie.title
    }
    var bodyLbl : String {
        movie.overview
    }
    var language : String {
        movie.original_language
    }
    var scoreLbl : String {
        "\(movie.vote_average)"
    }
    var posterImage : String {
        "\(Constants.IMAGEAPI.baseURLImage)\(movie.poster_path)"
    }
    var popularaty : Double {
        movie.popularity
    }
    var relaseDate : String {
        movie.release_date
    }
    var orginalTitle : String {
        movie.original_title
    }
    var voteCont: Double {
        Double(movie.vote_count)
    }
    var bacDropPath : String {
        "\(Constants.IMAGEAPI.baseURLImage)\(movie.backdrop_path)"
    }
}


