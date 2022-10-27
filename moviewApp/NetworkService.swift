//
//  NetworkService.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import Moya

enum NetworkService {
    case trendAll
    case trendMovie
    case trendTV
    case search(word:String)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .trendAll:
            return "trending/movie/week"
        case .trendMovie:
            return "movie/top_rated/"
        case .trendTV:
            return "tv/top_rated/"
        case .search(let word):
            return "search/multi/query=\(word)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        let apiKey = "c6a1c7e2e9eda9d872a83caff2d3ca91"
        switch self {
        case .trendAll:
            let params = ["api_key":"\(apiKey)"]
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


