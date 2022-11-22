//
//  LatestMovieViewCell.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/21.
//

import UIKit
import SnapKit

class LatestMovieViewCell: UICollectionViewCell {
    lazy var container: UIView = {
       let view = UIView()
        return view
    }()
    lazy var title: UILabel = {
      let title = UILabel()
        return title
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
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        container.addSubview(title)
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
