//
//  DetailViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/30.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import SwiftUI

class DetailViewModel: RxFlow.Stepper, ObservableObject  {
    var steps = PublishRelay<Step>()
    var id: Int
    let network =  NetworkManager.shared
    let disposeBag = DisposeBag()
    @Published var title = "testestest"
    @Published var movieInfomation: [DetailMovie] = []

    
    init( id: Int) {
        self.id = id
        title = String(id)
        getData(id)
    }
    
    func getData(_ id:Int ){
        network.getData(path: .detail(id: id), DetailMovie.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print("여기 프린트로 \($0)")
                self.movieInfomation.append($0)
            }).disposed(by: disposeBag)
    }
    

    
}
