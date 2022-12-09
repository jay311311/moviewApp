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
    static let shared = NetworkManager()
    let dispoaseBag = DisposeBag()
    let provider = MoyaProvider<NetworkService>()
    
    func getData<T:Codable>(path: NetworkService, _ type: T.Type) -> Observable<T> {
        return provider.rx.request(path)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map{try JSONDecoder().decode(T.self, from: $0.data) }
    }
    
    func string (decimal:Decimal) -> String {
        let numberForMatter =  NumberFormatter()
        numberForMatter.minimumFractionDigits = 2
        numberForMatter.roundingMode = .floor
        return numberForMatter.string(from: decimal as NSDecimalNumber) ?? ""
    }
}

