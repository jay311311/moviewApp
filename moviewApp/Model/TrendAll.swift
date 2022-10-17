//
//  TrendAll.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/17.
//

import Foundation

struct TrendAll: Codable {
    var page: Int
    var results: [AllInfo]
}

struct AllInfo: Codable {
    var backdrop_path: String
    var id: Int
    var name: String
    var overview: String
    var poster_path: String
    var genre_ids: [Int]
    var media_type: String
    var vote_average: Double
    var origin_country: [String]
}
               
