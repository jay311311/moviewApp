//
//  TopRatePalleteview.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/04.
//

import UIKit
import RxCocoa
import RxSwift

class TopRatePalleteview: UIScrollView {
    let result =  BehaviorRelay<[TopRateMovie]>(value: [])
    let action =  PublishRelay<TopRateActionType>()
    let disposeBag = DisposeBag()

    lazy var topRateCollection: UICollectionView = {
       let collection  = UICollectionView()
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDI(actionRely: PublishRelay<TopRateActionType>) {
        action.bind(to: actionRely).disposed(by: disposeBag)
    }
    func setupDI(dataRelay: BehaviorRelay<[TopRateMovie]>){
        result.bind(to: dataRelay).disposed(by: disposeBag)
    }
    
}
