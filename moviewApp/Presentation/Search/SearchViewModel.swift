//
//  SearchViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//
import Foundation
import RxFlow
import RxSwift
import RxCocoa
import ReactorKit

class SearchViewModel: Stepper, Reactor  {
    let initialState: State = State()
    
    enum Action {
        case tapReturn(String?)
    }
    
    enum Mutation{
        case endTexting([ResultMovie])
    }
    
    struct State {
        var moviewList: [ResultMovie] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapReturn(let word):
            guard let word = word else { return Disposables.create() as! Observable<SearchViewModel.Mutation>}
//            let what  = network.getData(path: .search(word: word), SearchMovie.self)
            return  network.getData(path: .search(word: word), SearchMovie.self).flatMap { result in
                return Observable.just(.endTexting(result.results))
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation{
        case .endTexting(let result):
            var newState = state
            newState.moviewList = result
            return newState
        }
    }
   
    
    let steps = PublishRelay<Step>()
    let network = NetworkManager.shared
    let resultMovie = BehaviorRelay<[ResultMovie]>(value: [])
    
    init(){ }
    
    //1. 검색결과 없을시 안내문구 생성
    //2. reatorkit을 통한 검색결과 데이터 바인딩
//    func getData(_ word: String?) -> Observable<[ResultMovie]>  {
//        guard let word =  word else { return }
//       let result =
//
//    }
}



