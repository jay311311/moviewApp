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
    let dispoaseBag  = DisposeBag()
    let provider = MoyaProvider<NetworkService>()
    private init() { }
    
    func getData() -> Observable<TrendAll> {
        return  provider.rx.request(.trendAll)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map{try JSONDecoder().decode(TrendAll.self, from: $0.data) }
    }
}

