//
//  NetworkManager.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/21.
//

import Foundation
import RxSwift
import Moya

class NetworkManager {
    static let shared  = NetworkManager()
    
    private init() { }

    func makeUrl(path: String = "trending/movie/week") -> URL{
        
        var API_KEY = Storage().apiKey
        var movieURL = URLComponents(string: "https://api.themoviedb.org/3/\(path)?")!
        var languageQuery = URLQueryItem(name: "language", value: "ko")
        var apiKey = URLQueryItem(name: "api_key", value: API_KEY)
        movieURL.queryItems?.append(apiKey)
        movieURL.queryItems?.append(languageQuery)
        return movieURL.url!
    }


    func loadData(){
        let config = URLSessionConfiguration.default
        // session 설정
        let session = URLSession(configuration: config)
        // dataTask 설정
        let url  = makeUrl()
        print("여기 상태 url : \(url)")

        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("여기 상태 메세지 : \(statusCode)")
            let successRange = 200..<300
            guard successRange.contains(statusCode) else { return }
     
            guard let resultData = data else { return }
            do {
                let data  =  try JSONDecoder().decode(TrendAll.self, from: resultData)
                print("여기여기 \(data)")
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        dataTask.resume()
    }


  

//    let provider = MoyaProvider<NetworkService>()
//    func getData(){
//        provider.rx.request(.trendAll)
//            .map(TrendAll.self)
//            .subscribe { response in
//                switch response{
//                case  .success(let data):
//                    print("여기0. \(data)")
//                    do{
//                        let decode = try JSONDecoder().decode(TrendAll.self, from: data)
//
//                    } catch let DecodingError.dataCorrupted(context) {
//                        print(context)
//                    } catch let DecodingError.keyNotFound(key, context) {
//                        print("Key '\(key)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.valueNotFound(value, context) {
//                        print("Value '\(value)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.typeMismatch(type, context)  {
//                        print("Type '\(type)' mismatch:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch {
//                        print("error: ", error)
//                    }
//                case .failure(let error):
//                    print("여기 뭔가 구조적으로 잘못됨 \(error.localizedDescription) \\ \(error)")
//                }
//
//            }
//    }
}
