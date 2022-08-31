//
//  Networkable.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import Moya
import Foundation

enum NetworkError : Error {
    case notFound
    case unexpectedError
}

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    func fetchPopularMovies(completion: @escaping (Result<Movies, Error>) -> ())
    func fetchTopRelatedMovies(completion: @escaping (Result<Movies, Error>) -> ())
    func fetchUpcommingMovies(completion: @escaping (Result<Movies, Error>) -> ())
    func fetchSearchMovies(query: String,completion: @escaping (Result<Movies, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPopularMovies(completion: @escaping (Result<Movies, Error>) -> ()) {
        request(target: .popular, completion: completion)
    }
    
    func fetchTopRelatedMovies(completion: @escaping (Result<Movies, Error>) -> ()) {
        request(target: .topRelated, completion: completion)
    }
    
    func fetchUpcommingMovies(completion: @escaping (Result<Movies, Error>) -> ()) {
        request(target: .upcomming, completion: completion)
    }
    func fetchSearchMovies(query: String, completion: @escaping (Result<Movies, Error>) -> ()) {
        request(target: .search(query: query), completion: completion)
    }
}

private extension NetworkManager {
    func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(responce):
                do{
                    let result = try JSONDecoder().decode(T.self, from: responce.data)
                    completion(.success(result))
                }catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
