//
//  ExtentionTableView.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import UIKit


extension TableViewVC {
    func segmentControlFunc() {
        switch segmentControl.selectedSegmentIndex {
   
        case 0:
            getData()
        case 1:
         
            networkManager.fetchTopRelatedMovies { [weak self] result in
                guard let strongS = self else { return}
                switch result {
                case .success(let popular):
                    strongS.movie = popular.results
                    strongS.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
           
        case 2:
            networkManager.fetchUpcommingMovies { [weak self] result in
                guard let strongS = self else { return}
                switch result {
                case .success(let popular):
                    strongS.movie = popular.results
                    strongS.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
           
        default:
            print("error")
        }
    }
    
    func getData() {
        networkManager.fetchPopularMovies { [weak self] result in
            guard let strongS = self else { return}
            switch result {
            case .success(let popular):
                strongS.movie = popular.results
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDataItems(items: String) {
        
    }

}

