//
//  Networkable.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import Moya
import Foundation
import RxSwift
import RxMoya
import UIKit

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    
    func fetchPopularMovies() -> Observable<Movies>
    func fetchTopRelatedMovies() -> Observable<Movies>
    func fetchUpcommingMovies() -> Observable<Movies>
    
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>()
    static let shared  = NetworkManager()
    
    func fetchPopularMovies() -> Observable<Movies> { request( .popular)}
    func fetchTopRelatedMovies() -> Observable<Movies> {request( .topRelated)}
    func fetchUpcommingMovies() -> Observable<Movies> { request( .upcomming)}
   
    func request<T: Codable>(_ request: API) -> Observable<T> {
        self.provider.rx
            .request(request)
            .asObservable()
            .filterSuccessfulStatusAndRedirectCodes().map{ (result) in
                return try result.map (T.self)
            }
            .catch { error in
                return Observable.error(error)
            }
    }
}
