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

enum HomeActionType {
    case tapMainslide
    case tapCollectionView
}

class HomeViewModel: Stepper {
    let steps = PublishRelay<Step>()
    let dispoaseBag  = DisposeBag()
    let weeklyMovie =  BehaviorRelay<[AllInfo]>(value: [])
    let network  = NetworkManager.shared
    let backgroudn_url = ""
    
    init(){  }
    
    struct Input{
        let refeshTrigger : PublishRelay<Void>
        let actionTrigger  : Observable<HomeActionType>
    }
    
    struct Output {
        let weeklyMovie: BehaviorRelay<[AllInfo]>
    }
    
    func getDatas() {
        network.getData()
            .subscribe(onNext: { [weak self] in
                self?.weeklyMovie.accept($0.results)
            }).disposed(by: dispoaseBag)
    }
    
    func transform(req: HomeViewModel.Input) -> HomeViewModel.Output{
        req.refeshTrigger.bind { [weak self] _ in
            self?.getDatas()
        }
        
     
        return Output(weeklyMovie: weeklyMovie )
    }
    

}
