//
//  TabBarViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/12.
//

import UIKit

class TabBarViewController : UITabBarController {
    
    let homeVC =  HomeViewController()
    let searchVC  =  SearchViewController()
    let theaterVC = TheaterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtn()
    }
    func setupBtn(){
        homeVC.title =  homeVC.mainTitle.text
        searchVC.title = searchVC.mainTitle.text
        theaterVC.title  =  theaterVC.mainTitle.text
        
        homeVC.tabBarItem.image = UIImage.init(systemName: "house")
        searchVC.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
        theaterVC.tabBarItem.image = UIImage.init(systemName: "ticket")
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        theaterVC.navigationItem.largeTitleDisplayMode = .always
        
        let navigationHome  =  UINavigationController(rootViewController: homeVC)
        let navigationSearch  =  UINavigationController(rootViewController: searchVC)
        let navigationTheater  =  UINavigationController(rootViewController: theaterVC)

        navigationHome.navigationBar.prefersLargeTitles = true
        navigationSearch.navigationBar.prefersLargeTitles = true
        navigationTheater.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navigationHome,navigationSearch,navigationTheater], animated: false)

    }
    
}




