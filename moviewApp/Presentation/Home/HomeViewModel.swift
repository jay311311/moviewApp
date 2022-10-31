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
    let weeklyMovieImg =  BehaviorRelay<[Data]>(value: [])
    let network  = NetworkManager.shared
    let backgroudn_url = ""
    
    init(){  }
    
    struct Input{
        let refeshTrigger : PublishRelay<Void>
        let actionTrigger  : Observable<HomeActionType>
    }
    
    struct Output {
        let weeklyMovie: BehaviorRelay<[AllInfo]>
        let weeklyMovieImg : BehaviorRelay<[Data]>
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
        urlToImage(weeklyMovie.value)
        
     
        return Output(weeklyMovie: weeklyMovie, weeklyMovieImg: weeklyMovieImg )
    }
    
    func urlToImage(_ datas: [AllInfo]) {
        for data in datas {
            let url =  URL(string : "https://image.tmdb.org/t/p/w500\(data.backdrop_path)")!
            let data = try? Data(contentsOf: url)
            var value = weeklyMovieImg.value
            value.append(data!)
            weeklyMovieImg.accept(value)
            print("여기. \(weeklyMovieImg.value)")
        }
    }
}
