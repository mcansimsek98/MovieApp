//
//  API.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import Moya
import SwiftUI

enum API {
    case popular
    case topRelated
    case upcomming
   
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError()}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .upcomming:
            return "movie/upcoming"
        case .topRelated:
            return "movie/top_rated"
        
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key" : Constants.API.apiKey], encoding: URLEncoding.queryString)
        case .topRelated:
            return .requestParameters(parameters: ["api_key" : Constants.API.apiKey], encoding: URLEncoding.queryString)
        case .upcomming:
            return .requestParameters(parameters: ["api_key" : Constants.API.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
 
}
