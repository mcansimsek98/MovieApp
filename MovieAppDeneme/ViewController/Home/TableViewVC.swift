//
//  ViewController.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit
import RxSwift
import SDWebImage

enum Section : Int {
    case popular = 0
    case topRelated = 1
    case upComming = 2
}

class TableViewVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    var sectionArray = ["Popular","Top Related", "Upcomming"]
    var popularMovieList : [HomeViewModel] = []
    var topRelatedMovieList : [HomeViewModel] = []
    var upcommingMovieList : [HomeViewModel] = []
    let movieListViewModel : MovieListViewModel = MovieListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    @IBOutlet var headImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callViewDidload()
        binViewModel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchMethod))
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
    
    @objc func searchMethod() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Search") as? SearchVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveOnMovieList(cindex: Int, index: Int ) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC else { return }
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
        switch indexPath.section {
        case Section.popular.rawValue:
            cell.movieList = popularMovieList
        case Section.topRelated.rawValue:
            cell.movieList = topRelatedMovieList
        case Section.upComming.rawValue:
            cell.movieList = upcommingMovieList
        default:
            print("error")
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
