//
//  MainSlideView.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/31.
//

import Foundation
import UIKit
import Kingfisher

class MainSlideViewController: UIViewController {
    var movieTitle: String = ""
    var posterURL: String = ""
    var overview: String = ""
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = movieTitle
        label.textColor = .white
        return label
    }()
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = overview
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    lazy var posterImg: UIImageView = {
        let imgView = UIImageView()
        if let url = URL(string: "https://image.tmdb.org/t/p/w400\(posterURL)") {
            imgView.kf.setImage(with: url)
        }
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    lazy var gradientLayer : CAGradientLayer = {
        let gradient =  CAGradientLayer()
        gradient.frame =  view.bounds
        gradient.startPoint =  CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint =  CGPoint(x: 0.5, y: 1.0)
        let colors:[CGColor] = [
            .init(red: 0, green: 0, blue: 0, alpha: 0),
            .init(red: 0, green: 0, blue: 0, alpha: 0.5),
            .init(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        gradient.colors = colors
//        gradient.locations = [0.6, 0.8]
        return gradient
    }()
    
    init?(movieTitle: String, posterURL: String, overview: String) {
        self.movieTitle = movieTitle
        self.posterURL = posterURL
        self.overview = overview
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        view.addSubview(posterImg)
        view.layer.addSublayer(gradientLayer)
        view.addSubviews([titleLabel,overviewLabel])

        posterImg.snp.makeConstraints{
            $0.top.equalToSuperview().offset(-20)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(overviewLabel.snp.top)
        }
        overviewLabel.snp.makeConstraints{
            $0.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
