//
//  TopRate.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/03.
//

import Foundation

struct TopRateMovies: Codable{
    var page: Int
    var results: [TopRateMovie]
}

struct TopRateMovie: Codable{
    var adult: Bool
    var title: String
    var id: Int
    var vote_average: Double
    var poster_path: String
}

struct TopRateTVs: Codable{
    var page: Int
    var results: [TopRateTV]
}

struct TopRateTV: Codable{
    var name: String
    var id: Int
    var vote_average: Double
    var poster_path: String
}
