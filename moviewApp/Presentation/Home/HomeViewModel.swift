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
    let network  = NetworkManager.shared
//
//    func fetData()  {
//        print(network)
//            self.network.getPosts()
//                .subscribe(onSuccess: { json  in
//                    print("여기 성공 \(json)")
//                },onError:{ error in
//                    print("여기 실패 \(error) ")
//
//                })
//
//    }
    
    init(){
        network.loadData()
    }
}
