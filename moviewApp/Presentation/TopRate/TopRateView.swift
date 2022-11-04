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

    lazy var segmentControl: UISegmentedControl = {
        let titles = ["Movies", "Episodes"]
        let segment = UISegmentedControl(items: titles)
        segment.selectedSegmentIndex = 0
        segment.tintColor = .white
        segment.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        return segment
    }()
    
    lazy var topRatePalleteView: TopRatePalleteview = {
       let palletScroll = TopRatePalleteview()
        
        return palletScroll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapSegmentControl(){
         print("탭했따")
     }
    
    func setupLayout(){
        addSubviews([segmentControl, topRatePalleteView])
        segmentControl.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        topRatePalleteView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
