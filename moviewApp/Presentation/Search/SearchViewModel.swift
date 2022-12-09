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

class SearchViewModel: Stepper, Reactor {
    
    let steps = PublishRelay<Step>()
    let network = NetworkManager.shared
    let resultMovie = BehaviorRelay<[ResultMovie]>(value: [])
    
    let initialState: State = State()
    
    init(){ }
    
    enum Action {
        case tapReturn(String?)
        case tapCancel
    }
    
    enum Mutation{
        case endTexting([ResultMovie])
        case deleteAllText
    }
    
    struct State {
        var moviewList: [ResultMovie] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapReturn(let word):
            if let word  = word, word == "" {
                return Observable.just(.deleteAllText)
            }
            guard let word = word else { return Disposables.create() as! Observable<SearchViewModel.Mutation>}
            return network.getData(path: .search(word: word), SearchMovie.self).flatMap { result in
                return Observable.just(.endTexting(result.results))
            }
        case .tapCancel:
            return Observable.just(.deleteAllText)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation{
        case .endTexting(let result):
            var newState = state
            newState.moviewList = result
            return newState
        case .deleteAllText :
            var newState = state
            newState.moviewList = []
            return newState
        }
    }
}




