//
//  LatestMovieViewCell.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LatestMovieViewCell: UICollectionViewCell {
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
        imgView.contentMode = .scaleAspectFit
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
        
        container.addSubviews([title,rateAverage,posterImg, overView])
        posterImg.snp.makeConstraints {
            $0.verticalEdges.left.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(100)
        }
        title.snp.makeConstraints {
            $0.left.equalTo(posterImg.snp.right).offset(5)
            $0.top.equalToSuperview().inset(15)
        }
        overView.snp.makeConstraints {
            $0.left.equalTo(title.snp.left)
            $0.top.equalTo(title.snp.bottom)
            $0.right.equalToSuperview()
        }
        rateAverage.snp.makeConstraints {
            $0.left.equalTo(title.snp.left)
            $0.top.equalTo(overView.snp.bottom)
        }
    }
}
