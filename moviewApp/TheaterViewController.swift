//
//  TheaterViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit
import SnapKit

class TheaterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    let mainTitle:UILabel  = {
        let label  =  UILabel()
        label.text =  "영화관"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    func setupUI(){
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }

}
