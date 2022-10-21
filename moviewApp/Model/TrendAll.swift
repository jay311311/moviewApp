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
    var adult: Bool
    var backdrop_path: String
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var media_type : String
    var genre_ids: [Int]
    var release_date: String
    var vote_average: Double
}
               
