//
//  SearchTableViewCell.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/08.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchTableViewCell.self)
    
    lazy var title: UILabel = {
        let label =  UILabel()
        return label
    }()
    lazy var posterImg: UIImageView = {
        let image  =  UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var rate: UILabel = {
       let label  =  UILabel()
        return label
    }()
    lazy var overview: UILabel = {
       let label  =  UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubviews([ posterImg, title, overview, rate])
        
        posterImg.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(140)
            $0.left.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(posterImg.snp.top).offset(10)
            $0.left.equalTo(posterImg.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
        overview.snp.makeConstraints {
            $0.left.equalTo(title.snp.left)
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.right.equalToSuperview()
        }
        rate.snp.makeConstraints {
            $0.left.equalTo(title.snp.left)
            $0.top.equalTo(overview.snp.bottom).offset(5)
            $0.right.equalToSuperview()
        }
        
    }
    
    func setupCell(item : ResultMovie){
        self.title.text = item.original_title
        self.rate.text = String(item.vote_average) ?? ""
        self.overview.text = item.overview
        self.posterImg.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w400\(item.poster_path)" ))
    }
}
