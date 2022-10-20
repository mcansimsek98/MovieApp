//
//  Model.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import Foundation

struct Movies: Codable {
    let results: [TheMovie]
}

struct TheMovie : Codable {
    let backdrop_path: String?
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let vote_average: Double
    let vote_count: Int
}
