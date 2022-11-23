//
//  LatestMovie.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/03.
//

import Foundation

struct LatestMovie: Codable {
    var dates: MiniMaxTerm
    var page: Int
    var results: [Movie]
}

struct MiniMaxTerm: Codable {
    var maximum: String
    var minimum: String
}

struct Movie: Codable {
    var adult: Bool
    var original_title: String
    var id: Int
    var vote_average: Double
    var poster_path: String
    var overview: String
}
