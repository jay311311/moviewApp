//
//  SearchViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SearchViewController: UIViewController {

    var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let searchController = SearchBarController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigation()
    }
    func setupNavigation(){
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.reactor
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "검색"
        return label
    }()
    
    func setupLayout(){
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }
    

}



