//
//  DetailMoview.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/30.
//

import Foundation

struct DetailMovie: Codable {
    var id: Int
    var title: String
    var vote_average: Double
    var runtime: Int
    var release_date: String
    var tagline: String
    var status: String
    var overview: String
    var homepage: String
    var imdb_id: String
    var poster_path: String
}
