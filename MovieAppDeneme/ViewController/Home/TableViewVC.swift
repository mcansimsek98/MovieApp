//
//  ViewController.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit
import RxSwift
import SDWebImage


class TableViewVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    var sectionArray = ["Popular","Top Related", "Upcomming"]
    var popularMovieList : [HomeViewModel] = []
    var topRelatedMovieList : [HomeViewModel] = []
    var upcommingMovieList : [HomeViewModel] = []
    let movieListViewModel : MovieListViewModel = MovieListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        callViewDidload()
        binViewModel()
        
    }

    func callViewDidload() {
        title = "The Movie DP"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func binViewModel(){
        movieListViewModel.downloadMovies()
        movieListViewModel.upcominMovieList.subscribe(onNext: { response in
            self.popularMovieList = response
            self.popularMovieList.sort() {
                $1.scoreLbl < $0.scoreLbl
            }
            self.popularMovieList = self.movieListViewModel.popularMovies
            self.topRelatedMovieList = self.movieListViewModel.topRelatedMovies
            self.upcommingMovieList = self.movieListViewModel.upcominMovies
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func moveOnMovieList(cindex: Int, index: Int ) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC else { return }
        //vc.selectedArray = popularMovieList[cindex]
        if index == 0 {
            vc.selectedArray = popularMovieList[cindex]
        }else if index == 1 {
            vc.selectedArray = topRelatedMovieList[cindex]
        }else if index == 2 {
            vc.selectedArray = upcommingMovieList[cindex]
        }else {
            print( "error")
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: Tableview
extension TableViewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.movieList = popularMovieList
        }else if indexPath.section == 1 {
            cell.movieList = topRelatedMovieList
        }else if indexPath.section == 2 {
            cell.movieList = upcommingMovieList
        }else {
            print( "error")
        }
        cell.didSelectItemAction = { colIndex in
            if let colIndexp = colIndex {
                self.moveOnMovieList(cindex: colIndexp, index: indexPath.section)
            }
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
}





//    override func viewWillAppear(_ animated: Bool) {
//        //        bindPopularViewModel()
//        //        bindTopRelatedViewModel()
//        //        bindUpcomingViewModel()
//        binViewModel()
//    }



//    func bindPopularViewModel() {
//        movieListViewModel.downloadMovies()
//        movieListViewModel.popularMovieList.subscribe(onNext: { response in
//            self.popularMovieList = response
//            self.popularMovieList.sort() {
//                $1.scoreLbl < $0.scoreLbl
//            }
//            //self.tableView.reloadData()
//        }).disposed(by: disposeBag)
//    }
//    func bindTopRelatedViewModel() {
//        movieListViewModel.downloadTopRelated()
//        movieListViewModel.topRelatedMovieList.subscribe(onNext: { response in
//            self.topRelatedMovieList = response
//            self.topRelatedMovieList.sort() {
//                $1.scoreLbl < $0.scoreLbl
//            }
//            // self.tableView.reloadData()
//        }).disposed(by: disposeBag)
//    }
//    func bindUpcomingViewModel() {
//        movieListViewModel.downloadUpcomming()
//        movieListViewModel.upcominMovieList.subscribe(onNext: { response in
//            self.upcommingMovieList = response
//            self.upcommingMovieList.sort() {
//                $1.scoreLbl < $0.scoreLbl
//            }
//            //    self.tableView.reloadData()
//        }).disposed(by: disposeBag)
//    }
//


// MARK: SegmentControl
/*
 extension TableViewVC {
 func segmentControlFunc() {
 switch segmentControl.selectedSegmentIndex {
 case 0:
 movieListViewModel.downloadMovies()
 case 1:
 movieListViewModel.downloadTopRelated()
 case 2:
 movieListViewModel.downloadUpcomming()
 default:
 print("error segment")
 }
 }
 }
 */

/*
 if searchActive {
 
 let filterMovie = filtered[indexPath.row]
 cell.titleLbl.text = filterMovie.title
 cell.bodyLbl.text = filterMovie.bodyLbl
 cell.languageLbl.text = "Languege: " + "\(filterMovie.language)".uppercased()
 cell.scoreLbl.text = "Vote Avarege: \(filterMovie.scoreLbl)"
 let urlString = "https://image.tmdb.org/t/p/w500\(filterMovie.posterImage)"
 let imageUrl: NSURL? = NSURL(string: urlString)
 if let imageUrl = imageUrl {
 cell.imageViewCell.sd_setImage(with: imageUrl as URL)
 }
 } else {
 let movies = movieList[indexPath.row]
 cell.titleLbl.text = movies.title
 cell.bodyLbl.text = movies.bodyLbl
 cell.languageLbl.text = "Languege: " + "\(movies.language)".uppercased()
 cell.scoreLbl.text = "Vote Avarege: \(movies.scoreLbl)"
 let urlString = movies.posterImage
 let imageUrl: NSURL? = NSURL(string: urlString)
 if let imageUrl = imageUrl {
 cell.imageViewCell.sd_setImage(with: imageUrl as URL)
 }
 }*/


//    let searchbarController = UISearchController()
//    var searchActive = false
//    var filtered : [HomeViewModel] = []




/*
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 if searchActive {
 return filtered.count
 }
 return movieList.count
 
 }*/




/*
 
 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 filtered = movieList.filter({ item in
 item.title.localizedStandardContains(searchText)
 })
 searchActive = !filtered.isEmpty
 self.tableView.reloadData()
 }
 
 }*/

//        searchbarController.searchBar.delegate = self
//        navigationItem.searchController = searchbarController
