//
//  HomeView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/31.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class HomeView: UIView{
    let weeklyMovieSlide = BehaviorRelay<[AllInfo]>(value: [])
    let actionRelay = PublishRelay<HomeActionType>()
 
    let disposeBag =  DisposeBag()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let widthSize = UIScreen.main.bounds.width * 0.4
        let heightSize = 120.0
        layout.itemSize =  CGSize(width: widthSize, height: heightSize)
        let collection =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        dataBinding()
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        collectionView.register(SubMovieListCell.self, forCellWithReuseIdentifier: "SubCell")

    addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    func dataBinding(){
        weeklyMovieSlide.bind(to: collectionView.rx.items(cellIdentifier: "SubCell",cellType: SubMovieListCell.self)){
            index, data, cell in
            if let url = URL(string: "https://image.tmdb.org/t/p/w400\(data.poster_path)") { cell.posterImg.kf.setImage(with: url) }
            cell.title.text = data.title
            cell.overView.text = data.overview
            cell.movieId = data.id
        }
    }
    
    func setupDI(observable: BehaviorRelay<[AllInfo]>) {
        observable.bind(to: weeklyMovieSlide).disposed(by: disposeBag)
    }
    /// 액션 연결.
    func setupDI(relay: PublishRelay<HomeActionType>) {
        actionRelay.bind(to: relay).disposed(by: disposeBag)
    }
}
