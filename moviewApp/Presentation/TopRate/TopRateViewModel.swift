//
//  TopRateViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//
import Foundation
import RxFlow
import RxSwift
import RxCocoa

enum TopRateActionType{
    case goDetail
}

class TopRateViewModel: Stepper  {
    let steps = PublishRelay<Step>()
    var movieResult = BehaviorRelay<[TopRateMovie]>(value: [])
    var tvResult = BehaviorRelay<[TopRateTV]>(value: [])
    let network  = NetworkManager.shared
    let disposeBag  = DisposeBag()
    
    init(){  }
    
    struct Input{
        var refreshTrigger : Observable<Void>
        var TopRateAcionTrigger : Observable<TopRateActionType>
    }
    
    struct Output{
        var topRateMovie : BehaviorRelay<[TopRateMovie]>?
        var topRateTV : BehaviorRelay<[TopRateTV]>?
    }
    
    func transform(req : TopRateViewModel.Input) -> TopRateViewModel.Output{
        req.refreshTrigger.bind{[weak self] _ in
            self?.getDatas()
        }
        
        req.TopRateAcionTrigger.bind(onNext: doAction)
        
        return Output(topRateMovie: movieResult, topRateTV: tvResult)
    }
    
    func getDatas(){
        network.getData(path: .topRateMovie, TopRateMovies.self)
            .subscribe(onNext:{ [weak self]  in
                self?.movieResult.accept($0.results)
            }).disposed(by: disposeBag)
    }
    
    func doAction(_ actionType: TopRateActionType){
        switch actionType{
        case .goDetail:
            goDetail()
        }
    }
    
    func goDetail(){
        print("해당 리스트 클릭")
    }
    
}
