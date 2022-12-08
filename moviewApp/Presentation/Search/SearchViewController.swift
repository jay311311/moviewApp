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
import ReactorKit

class SearchViewController: UIViewController {

    var disposeBag = DisposeBag()

    init(viewModel: SearchViewModel) {
        defer{ self.reactor = viewModel}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var searchBar = SearchBarController(searchResultsController: nil)
    lazy var searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigation()
    }
    func setupNavigation(){
        self.navigationItem.searchController = searchBar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "검색"
        return label
    }()
    
    func setupLayout(){
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    

}


extension SearchViewController: View {
    func bind(reactor: SearchViewModel) {
        searchView.bind(reactor: reactor)
        searchBar.bind(reactor: reactor)
    }
}

