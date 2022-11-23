//
//  HomeView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/31.
//

import Foundation
import UIKit
import SwiftUI

class HomeView: UIView{
    let vc = UIHostingController(rootView: ListSlider())
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
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
        container.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        container.addSubview(vc.view)
        vc.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
