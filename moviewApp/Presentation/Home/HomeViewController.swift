//
//  HomeViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftUI

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    let refreshTrigger = PublishRelay<Void>()
    let actionTrigger = PublishRelay<HomeActionType>()
    
    lazy var homeMainSlideView: HomeMainSlideViewController = {
    let mainSlideView = HomeMainSlideViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return mainSlideView
    }()
   
    lazy var subview: HomeView = {
        let view = HomeView()
        return view
    }()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("홈 끝")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
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
        view.addSubview(subview)
        
        subview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(homeMainSlideView.view.snp.bottom)
            $0.height.equalTo(200)
        }
        homeMainSlideView.view.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(550)
        }
    }
    
    func bindViewModel() {
        let res = viewModel.transform(req: HomeViewModel.Input(refeshTrigger: refreshTrigger.asObservable(), actionTrigger: actionTrigger.asObservable()))
        homeMainSlideView.setupDI(observable: res.weeklyMovie)
        homeMainSlideView.setupDI(relay: actionTrigger)
        subview.setupDI(observable: res.weeklyMovie)
        subview.setupDI(relay: actionTrigger)
    }
}
