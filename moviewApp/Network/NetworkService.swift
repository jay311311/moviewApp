//
//  NetworkService.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import Moya

enum NetworkService {
    case trendMovie
    case upcoming
    case nowPlaying
    case search(word:String)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .trendMovie:
            return "trending/movie/week"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .search(let word):
            return "search/multi"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        let apiKey = Storage().apiKey
        switch self {
        case .search(let word):
            let params = ["api_key":"\(apiKey)","query":"\(word)"]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        default :
            let params = ["api_key":"\(apiKey)"]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}


