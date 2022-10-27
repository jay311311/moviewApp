//
//  HomeViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa


class HomeViewModel: Stepper {
    let steps = PublishRelay<Step>()
    let dispoaseBag  = DisposeBag()
    let weeklyMovie =  BehaviorRelay<[AllInfo]>(value: [])
    lazy var network  = NetworkManager.shared
    
    init(){ getDatas() }
    
    func getDatas()  {
        network.getData()
            .subscribe(onNext: { [weak self] in
                self?.weeklyMovie.accept($0.results)
            })
    }
}
