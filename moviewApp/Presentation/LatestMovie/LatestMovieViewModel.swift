//
//  LatestMovieViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//
import Foundation
import RxFlow
import RxSwift
import RxCocoa

enum LatestMovieActionType {
    case goDetail
    case tapNowPlayingSegment
    case tapUpcomingSegment
}

class LatestMovieViewModel: Stepper {
    let steps = PublishRelay<Step>()
    let upcomingResult = BehaviorRelay<[Movie]>(value: [])
    var playingResult = BehaviorRelay<[Movie]>(value: [])
    var latestResult = BehaviorRelay<[Movie]>(value: [])
    let network = NetworkManager.shared
    let disposeBag = DisposeBag()
    
    init(){  getDatas()  }
    
    struct Input {
        var refreshTrigger: Observable<Void>
        var LatestAcionTrigger: Observable<LatestMovieActionType>
    }
    
    struct Output{
        var latestResult: BehaviorRelay<[Movie]>
    }
    
    func transform(req : LatestMovieViewModel.Input) -> LatestMovieViewModel.Output {
        req.refreshTrigger.bind{ [weak self] _ in
            guard let self = self else { return }
            self.latestResult.accept(self.playingResult.value)
        }
        req.LatestAcionTrigger.bind(onNext: doAction).disposed(by: disposeBag)
        return Output(latestResult: latestResult)
    }
    
    func getDatas() {
        network.getData(path: .nowPlaying, LatestMovie.self)
            .subscribe(onNext:{ [weak self] in
                guard let self  = self else { return }
                self.playingResult.accept($0.results)
            }).disposed(by: disposeBag)
        network.getData(path: .upcoming, LatestMovie.self)
            .subscribe(onNext:{ [weak self] in
                self?.upcomingResult.accept($0.results)
            }).disposed(by: disposeBag)
    }
    
   private func doAction(_ actionType: LatestMovieActionType) {
        switch actionType {
        case .goDetail:
            goDetail()
        case .tapNowPlayingSegment:
            tapNowPlaying()
        case .tapUpcomingSegment:
            tapUpcoming()
        }
    }
    
    func goDetail(){
        print("해당 리스트 클릭")
    }
    func tapNowPlaying(){
        latestResult.accept(playingResult.value)
    }
    func tapUpcoming(){
        latestResult.accept(upcomingResult.value)
    }
}
