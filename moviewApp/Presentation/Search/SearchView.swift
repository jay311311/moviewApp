//
//  SearchView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

class SearchView: UIView {

    let disposeBag = DisposeBag()
    lazy var tableView: UITableView = {
      let table  = UITableView()
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


extension SearchView {
    func bind(reactor: SearchViewModel ){
        bindAction(reator: reactor)
        bindState(reator: reactor)
    }
    
    func bindAction(reator: SearchViewModel){
        return
    }
    
    func bindState(reator: SearchViewModel){
        reator.state.compactMap { $0.moviewList }
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { index, item, cell in
                cell.setupCell(item: item)
            }.disposed(by: disposeBag)
    }
}
