//
//  HomeViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel
    lazy var homeMainSlideView: HomeMainSlideViewController = {
    let mainSlideView = HomeMainSlideViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return mainSlideView
    }()

    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "홈"
        return label
    }()

    func setupLayout() {
        addChild(homeMainSlideView)
        view.addSubview(homeMainSlideView.view)
        view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
        homeMainSlideView.view.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
    


  

}
