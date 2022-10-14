//
//  DetailViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "상세"
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
