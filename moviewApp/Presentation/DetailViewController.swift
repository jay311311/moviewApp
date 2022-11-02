//
//  DetailViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa


class DetailViewController: UIViewController {

    let viewModel : DetailViewModel
    let id : Int
    
    init(viewModel: DetailViewModel, id:Int) {
        self.viewModel = viewModel
        self.id = id
        mainTitle.text = "\(id)"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "상세"
        return label
    }()

    func setupUI() {
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }
}

class DetailViewModel: Stepper {
    var steps = PublishRelay<Step>()
    
    
    
}
