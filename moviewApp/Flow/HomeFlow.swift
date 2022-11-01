//
//  HomeFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa

class HomeFlow: Flow {
    var root : Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
//    private let networkService: NetworkService
    private let homeStepper: HomeViewModel
    
    init(withStepper steppers: HomeViewModel){
        self.homeStepper = steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep  else { return .none }
        switch step{
        case .home:
            return navigateToHomeScreen()
        case .detail(let id):
            return navigateToDetail()
        default:
            return .none
        }
    }
    
    private func navigateToHomeScreen() -> FlowContributors {
        let viewController = HomeViewController(viewModel: homeStepper)
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: homeStepper))
    }
    
    private func navigateToDetail() -> FlowContributors{
        let detailStepper = DetailViewModel()
        let viewController = DetailViewController(viewModel: DetailViewModel() )
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: detailStepper))
    }
}

