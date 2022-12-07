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
        case tapCancel
        case tapReturn(String?)
    }
    
    enum Mutation{
        case cancelTexting
        case endTexting(String?)
    }
    
    struct State {
        var text: String = ""
        var moviewList = BehaviorRelay<[ResultMovie]>(value: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapReturn(let word):
                getData(word)
                return Observable.just(Mutation.endTexting(word))
            
        case .tapCancel:
            return Observable.just(Mutation.cancelTexting)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation{
        case .cancelTexting:
            var newState = state
            newState.text = ""
            return newState
        case .endTexting(let word):
            guard let word = word else { return State.init(text: "")}
            var newState = state
            newState.text = word
            return newState
        }
    }
   
    
    let steps = PublishRelay<Step>()
    let network = NetworkManager.shared
    let resultMovie = BehaviorRelay<[ResultMovie]>(value: [])
    
    init(){ }
    
    //1. 검색결과 없을시 안내문구 생성
    //2. reatorkit을 통한 검색결과 데이터 바인딩
    func getData(_ word: String?)  {
        guard let word =  word else { return }
        network.getData(path: .search(word: word), SearchMovie.self)
            .subscribe(onNext:{ [weak self]  in
                guard let self  = self else { return }
                print("여기확인 검색 데이터. \($0.results) && \(word)")
                self.resultMovie.accept($0.results)
            })
    }
}



