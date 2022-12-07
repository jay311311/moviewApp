//
//  SearchMovie.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/07.
//

import Foundation

struct SearchMovie: Codable {
    var page: Int
    var results: [ResultMovie]
}

struct ResultMovie: Codable {
    var original_title: String
    var id: Int
    var poster_path: String
    var vote_average: Double
}
