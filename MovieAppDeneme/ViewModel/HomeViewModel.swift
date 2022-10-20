//
//  HomeViewModel.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 1.09.2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

// MARK: MovieListModel

class MovieListViewModel : ObservableObject {
    var popularMovieList = PublishSubject<[HomeViewModel]>()
    var topRelatedMovieList = PublishSubject<[HomeViewModel]>()
    var upcominMovieList = PublishSubject<[HomeViewModel]>()
    var similarMovieList = PublishSubject<[HomeViewModel]>()
    var searchMovieList = PublishSubject<[HomeViewModel]>()
    var popularMovies: [HomeViewModel] = []
    var topRelatedMovies: [HomeViewModel] = []
    var upcominMovies: [HomeViewModel] = []
    
    let disposeBag: DisposeBag = DisposeBag()

    func downloadMovies (){
        NetworkManager.shared.fetchPopularMovies().subscribe(onNext: { response in
            let mapMovies = response.results.map(HomeViewModel.init)
            self.popularMovies = mapMovies
            self.downloadTopRelated()
            //self.popularMovieList.onNext(mapMovies)
        },onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func downloadTopRelated () {
        NetworkManager.shared.fetchTopRelatedMovies().subscribe(onNext: {  response in
            let mapMovies = response.results.map(HomeViewModel.init)
            self.topRelatedMovies = mapMovies
            self.downloadUpcomming()
            //self.topRelatedMovieList.onNext(mapMovies)
        },onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func downloadUpcomming () {
        NetworkManager.shared.fetchUpcommingMovies().subscribe(onNext: { response in
            let mapMovies = response.results.map(HomeViewModel.init)
            self.upcominMovies = mapMovies
            self.upcominMovieList.onNext(mapMovies)
        },onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func detailMovies(id: Int) {
        NetworkManager.shared.fetchSimilarMovies(id:id ).subscribe(onNext: { response in
            let mapMovies = response.results.map(HomeViewModel.init)
            self.similarMovieList.onNext(mapMovies)
        },onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func searchMovies() {
        NetworkManager.shared.fetchSearchMovies().subscribe(onNext: { response in
            let mapMovies = response.results.map(HomeViewModel.init)
            self.searchMovieList.onNext(mapMovies)
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    

    
}

// MARK: HomeViewModel

struct HomeViewModel {
    let movie : TheMovie
    
    var id: Int {
        movie.id
    }
    
    var title : String {
        movie.title
    }
    var bodyLbl : String {
        movie.overview
    }
    var language : String {
        movie.original_language
    }
    var scoreLbl : Double {
        movie.vote_average
    }
    var posterImage : String {
        "\(Constants.IMAGEAPI.baseURLImage)\(movie.poster_path ?? "" )"
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
        "\(Constants.IMAGEAPI.baseURLImage)\(movie.backdrop_path ?? "")"
    }
}


