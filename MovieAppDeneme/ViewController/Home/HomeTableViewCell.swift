//
//  HomeTableViewCell.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 3.09.2022.
//

import UIKit

typealias DidSelectClosure = ((_ collectionIndex: Int?)-> Void)

class HomeTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    var didSelectItemAction: DidSelectClosure?
    var movieList : [HomeViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        call()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func call() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { fatalError() }
        let movie = movieList[indexPath.row]
        let urlString = movie.posterImage
        let imageUrl: NSURL? = NSURL(string: urlString)
        if let imageUrl = imageUrl {
            cell.imageView.sd_setImage(with: imageUrl as URL)
        }
        cell.titleLbl.text = "\(movie.title)"
        cell.scoreLbl.text = "Vote Average: \(movie.scoreLbl)"
        cell.bodyLbl.text = " \(movie.bodyLbl)"
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.imageView.layer.borderWidth = 3
        cell.imageView.layer.cornerRadius = 4
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath.row)
    }
}


















//        switch indexPath.section {
//        case Section.popular.rawValue:
//            movieListViewModel.downloadMovies()
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell else { fatalError() }
//            return cell
//        case Section.topRelated.rawValue:
//            movieListViewModel.downloadTopRelated()
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRelatedCollectionViewCell", for: indexPath) as? TopRelatedCollectionViewCell else { fatalError() }
//            return cell
//        case Section.upComming.rawValue:
//            movieListViewModel.downloadUpcomming()
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as? UpcomingCollectionViewCell else { fatalError() }
//            return cell
//        default:
//            print("error")
//        }

// if collectionView = PopularCollectionViewCell {







//enum Section : Int {
//    case popular = 0
//    case topRelated = 1
//    case upComming = 2
//}




//    func bindViewModel() {
//        movieListViewModel.downloadMovies()
//        movieListViewModel.downloadTopRelated()
//        movieListViewModel.downloadUpcomming()
//        movieListViewModel.movieList.subscribe(onNext: { response in
//            self.movieList = response
//            self.movieList.sort() {
//                $1.scoreLbl < $0.scoreLbl
//            }
//            self.collectionView.reloadData()
//        }).disposed(by: disposeBag)
//    }
