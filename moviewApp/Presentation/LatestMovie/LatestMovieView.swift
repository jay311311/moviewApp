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
        let collection =  UICollectionView()
        
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
            // 콜렉션뷰 리로드 예정

        case 1 :
            action.accept(.tapUpcomingSegment)
            // 콜렉션뷰 리로드 예정

        default:
            break
        }
     }
    
    func setupLayout() {
//        collectionView.register(LatestMovieViewCell, forCellWithReuseIdentifier: <#T##String#>)
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
       
    }
    
    func setupDI(actionRely: PublishRelay<LatestMovieActionType>) {
        action.bind(to: actionRely).disposed(by: disposeBag)
    }
    func setupDI(dataRelay: BehaviorRelay<[Movie]>){
        latestResult.bind(to: dataRelay).disposed(by: disposeBag)
        print("확인 현장. \(latestResult.value)")
    }

}
