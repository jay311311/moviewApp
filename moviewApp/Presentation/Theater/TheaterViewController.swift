//
//  CategoryViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {

    var viewModel: CategoryViewModel
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        return label
    }()
    
    func setupLayout(){
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }
    

}
