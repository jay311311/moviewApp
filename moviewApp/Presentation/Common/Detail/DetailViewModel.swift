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
    @Published var movieInfomation: DetailMovie? = nil

    
    init( id: Int) {
        self.id = id
        getData(id)
    }
    
    func getData(_ id:Int ){
        network.getData(path: .detail(id: id), DetailMovie.self)
            .subscribe(onNext: { [weak self]  in
                guard let self = self else { return }
                self.movieInfomation = DetailMovie(id: $0.id, title: $0.title, vote_average: $0.vote_average, runtime: $0.runtime, release_date: $0.release_date, tagline: $0.tagline, status: $0.status, overview: $0.overview, homepage: $0.homepage, imdb_id: $0.imdb_id, poster_path: $0.poster_path)
            }).disposed(by: disposeBag)
    }
    
    
    

    
}
