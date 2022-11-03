//
//  TopRateView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/03.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TopRateView: UIView {
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "검색"
        return label
    }()
    lazy var segmentControl : UISegmentedControl = {
       let segment  =  UISegmentedControl()
//        segment.setTitle("Movies", forSegmentAt: 0)
//        segment.setTitle("Episodes", forSegmentAt: 1)
        segment.tintColor = .white
        segment.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        return segment
    }()

   @objc func tapSegmentControl(){
        print("탭했따")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubviews([mainTitle,segmentControl])
        mainTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(segmentControl.snp.top)
        }
        segmentControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
}
