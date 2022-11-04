//
//  TopRateViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit
import RxFlow
import RxCocoa

class TopRateViewController: UIViewController {
    
    var viewModel: TopRateViewModel
    let refreshTrigger = PublishRelay<Void>()
    var actionRelay = PublishRelay<TopRateActionType>()
//    var topRateMovie = BehaviorRelay<[TopRateMovie]>(value: [])
    var topRateTV = BehaviorRelay<[TopRateTV]>(value: [])
    
    init(viewModel: TopRateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        refreshTrigger.accept(())

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        setupLayout()
        bindViewModel()
        
    }

    lazy var subViews: TopRateView = {
       let view  =  TopRateView()
        return view
    }()

    func setupNavigationTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Top Rate"
    }
    func setupLayout() {
        self.view.addSubview(subViews)
        subViews.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel(){
       let result = viewModel.transform(req: TopRateViewModel.Input(refreshTrigger: refreshTrigger.asObservable(), TopRateAcionTrigger: actionRelay.asObservable()))

//            topRateMovie.accept(movieResult.value)
            subViews.topRatePalleteView.setupDI(actionRely: actionRelay)
        subViews.topRatePalleteView.setupDI(dataRelay: result.topRateMovie)
    }
}
