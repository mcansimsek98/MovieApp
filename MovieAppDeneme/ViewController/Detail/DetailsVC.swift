//
//  DetailsVC.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit
import RxSwift
import SDWebImage


class DetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var orginalTitleLbl: UILabel!
    @IBOutlet var Language: UILabel!
    @IBOutlet var relaseDate: UILabel!
    @IBOutlet var popularty: UILabel!
    @IBOutlet var voteCount: UILabel!
    @IBOutlet var bodyLBL: UILabel!
    @IBOutlet var collectionVeiw: UICollectionView!
    let movieListViewModel : MovieListViewModel = MovieListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    var selectedArray: HomeViewModel?
    var detailsMovies : [HomeViewModel] = [] {
        didSet {
            self.collectionVeiw.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard selectedArray != nil else {return}
        getDetailData()
        getImage()
        collectionVeiw.delegate = self
        collectionVeiw.dataSource = self
        DispatchQueue.main.async {
            self.binViewModel()
        }
        
        title = "\(selectedArray?.title ?? "")"
    }
  
    func binViewModel(){
        movieListViewModel.detailMovies(id: selectedArray?.id ?? 0)
        movieListViewModel.similarMovieList.subscribe(onNext: { response in
            self.detailsMovies = response
            self.detailsMovies.sort() {
                $1.scoreLbl < $0.scoreLbl
            }
            self.collectionVeiw.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCell else { fatalError("Detail cell problem")}
        let movie = detailsMovies[indexPath.item]
        
        let urlString = movie.posterImage
        let imageUrl: NSURL? = NSURL(string: urlString)
        if let imageUrl = imageUrl {
            cell.detailImageCell.sd_setImage(with: imageUrl as URL)
        }
        
        cell.detailTitleLbl.text = "\(movie.title)"
        cell.scoreLbl.text = "Vote Average: \(movie.scoreLbl)"
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 10
        cell.detailImageCell.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.detailImageCell.layer.borderWidth = 2
        cell.detailImageCell.layer.cornerRadius = 4
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsVC {
            vc.selectedArray = detailsMovies[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension DetailsVC {
    
    func getDetailData() {
        titleLbl.text = selectedArray?.title ?? "".uppercased()
        bodyLBL.text = "     \(selectedArray?.bodyLbl ?? "")"
        popularty.text = "Popularity: " + "\(selectedArray?.popularaty ?? 000)"
        relaseDate.text = "Relase Date: " + "\(selectedArray?.relaseDate ?? "")"
        orginalTitleLbl.text = "Orginal Title: " + "\(selectedArray?.orginalTitle ?? "")".uppercased()
        voteCount.text = "Vote Avarege: " + "\(selectedArray?.scoreLbl ?? 0.0)"
        Language.text = "Language: " + "\(selectedArray?.language ?? "")".uppercased()

    }
    
    func getImage() {
        let image = selectedArray?.bacDropPath ?? ""
        let imageUrl: NSURL? = NSURL(string: image)
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: imageUrl as URL)
        }
        imageView.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 4
    }
}

































//navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
//    @objc func shareButton() {
//        let item = selectedArray?.title ?? ""
//        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [] )
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true)
//    }
    
