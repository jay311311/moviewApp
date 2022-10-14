//
//  SearchViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "검색"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupUI() {
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }
    
}
