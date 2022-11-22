//
//  LatestMovieViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit
import RxFlow
import RxCocoa

class LatestMovieViewController: UIViewController {
    var viewModel: LatestMovieViewModel
    var refreshTrigger = PublishRelay<Void>()
    var actionRelay = PublishRelay<LatestMovieActionType>()
    
    init(viewModel: LatestMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    override func viewWillAppear(_ animated: Bool) {
        refreshTrigger.accept(())
        subViews.collectionView.reloadData()
    }

    lazy var subViews: LatestMovieView = {
       let view = LatestMovieView()
        return view
    }()

    func setupNavigationTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Latest"
    }
    func setupLayout() {
        self.view.addSubview(subViews)
        subViews.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        let result = viewModel.transform(req: LatestMovieViewModel.Input(refreshTrigger: refreshTrigger.asObservable(), LatestAcionTrigger: actionRelay.asObservable()))
        subViews.setupDI(actionRely: actionRelay)
        subViews.setupDI(dataRelay: result.latestResult)
    }
}
