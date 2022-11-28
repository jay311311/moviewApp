//
//  TrendMovie.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/17.
//

import Foundation

struct TrendMovie: Codable {
    let results: [AllInfo]
    let page: Int
}

struct AllInfo: Codable,Hashable {
    let adult: Bool
    let backdrop_path: String?
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let media_type : String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}

               
