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
    case tapDetail(id: Int)
}

class HomeViewModel: Stepper {
    let steps = PublishRelay<Step>()
    let dispoaseBag = DisposeBag()
    let weeklyMovie = BehaviorRelay<[AllInfo]>(value: [])
    let network = NetworkManager.shared
    
    init(){ getDatas() }
    
    struct Input {
        let refeshTrigger: Observable<Void>
        let actionTrigger: Observable<HomeActionType>
    }
    
    struct Output {
        let weeklyMovie: BehaviorRelay<[AllInfo]>
    }
    
    func getDatas() {
        network.getData(path: .trendMovie, TrendMovie.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.weeklyMovie.accept($0.results)
            }).disposed(by: dispoaseBag)
    }
    
    func transform(req: HomeViewModel.Input) -> HomeViewModel.Output {
  
        req.actionTrigger.bind(onNext: doAction).disposed(by: dispoaseBag)
        
        return Output(weeklyMovie: weeklyMovie )
    }
    
    private func doAction(_ actionType: HomeActionType) {
        switch actionType {
        case .tapDetail(let id):
            return   self.steps.accept(MainStep.detail(id: id))
        }
    }
}
