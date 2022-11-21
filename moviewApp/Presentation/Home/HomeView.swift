//
//  HomeView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/31.
//

import Foundation
import UIKit

class HomeView: UIView{
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
    }
}
