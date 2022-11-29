//
//  LatestMovieView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/03.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Kingfisher

class LatestMovieView: UIView {
    let latestResult = BehaviorRelay<[Movie]>(value: [])
    let action = PublishRelay<LatestMovieActionType>()
    let disposeBag = DisposeBag()
    
    lazy var segmentControl: UISegmentedControl = {
        let titles = ["Now Playing", "Upcoming"]
        let segment = UISegmentedControl(items: titles)
        segment.selectedSegmentIndex = 0
        segment.tintColor = .white
        segment.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        return segment
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let widthSize = UIScreen.main.bounds.width * 0.78
        let heightSize = 120.0
        layout.itemSize =  CGSize(width: widthSize, height: heightSize)
        let collection =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        bindData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapSegmentControl() {
        switch  segmentControl.selectedSegmentIndex {
        case 0 :
            action.accept(.tapNowPlayingSegment)
            collectionView.reloadData()
        case 1 :
            action.accept(.tapUpcomingSegment)
            collectionView.reloadData()
        default:
            break
        }
     }
    
    func setupLayout() {
        collectionView.register(LatestMovieViewCell.self, forCellWithReuseIdentifier: "cell")
        addSubviews([segmentControl, collectionView])
        segmentControl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func bindData(){
        latestResult.bind(to:collectionView.rx.items(cellIdentifier: "cell", cellType: LatestMovieViewCell.self)){
            index, data, cell  in
            if let url = URL(string: "https://image.tmdb.org/t/p/w400\(data.poster_path)") { cell.posterImg.kf.setImage(with: url) }
            cell.title.text = data.original_title
            cell.rateAverage.text = String(data.vote_average)
            cell.overView.text = data.overview
            cell.movieId = data.id
        }
            
        collectionView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] data in
                self?.action.accept(.tapDetail(data.id))
            })
    }
    
    func setupDI(actionRely: PublishRelay<LatestMovieActionType>) {
        action.bind(to: actionRely).disposed(by: disposeBag)
    }
    func setupDI(dataRelay: BehaviorRelay<[Movie]>){
        dataRelay.bind(to: latestResult).disposed(by: disposeBag)
    }
}
