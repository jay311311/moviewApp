//
//  SubMovieListCell.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/28.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SubMovieListCell: UICollectionViewCell {
    var posterURL: String?
    var movieId: Int? = nil
    
    var action = PublishRelay<LatestMovieActionType>()
    let dispoaseBag = DisposeBag()
    
    lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        return title
    }()
    
    lazy var rateAverage: UILabel = {
        let rate = UILabel()
        return rate
    }()
    
    lazy var overView: UILabel = {
        let overView = UILabel()
        overView.numberOfLines = 2
        overView.lineBreakMode = .byTruncatingTail
        return overView
    }()
    
    lazy var posterImg: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.contentMode = .scaleAspectFill
        imgView.tag = movieId ?? 0
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(container)
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        container.addSubviews([rateAverage,posterImg,title])
        posterImg.snp.makeConstraints {
            $0.verticalEdges.left.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(100)
        }
        title.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.right.equalTo(posterImg.snp.right)
            $0.bottom.equalToSuperview()
        }
     
        rateAverage.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}
