//
//  NetworkManager.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/21.
//

import Foundation
import RxSwift
import Moya

struct NetworkManager {
    
    
    static let shared  = NetworkManager()
    private init() {}
    let provider = MoyaProvider<NetworkService>()
        
    func getData(){
        print("시작한다")
        provider.rx.request(.trendAll).subscribe { response in
            switch response{
            case  .success(let sucess):
                let data  = sucess.data
                do{
                    let decode = try JSONDecoder().decode(TrendAll.self, from: data)
                    print(decode.results)
                }catch(let error){
                    print("여기  \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("여기 뭔가 구조적으로 잘못됨 \(error.localizedDescription)")
            }
     
    }
   
       
//        provider.request(.trendAll) { result in
//            switch result {
//            case .success(let data):
//                if let model  =
//                let items = data.data
//                print("여기 성공 \(data.data)")
//            case .failure(let error):
//                print("여기 실패 \(error.errorUserInfo) \\ \(error.localizedDescription)")
//            }
//        }
    }
    
//    func getPosts() -> Single<[TrendAll]> {
//        return provider.rx
//            .request(.trendAll)
//            .filterSuccessfulStatusCodes()
//            .map([TrendAll].self)
//    }

}
