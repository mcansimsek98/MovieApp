//
//  SearchModel.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import Foundation

struct SearchResponse: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Movies]?

}
