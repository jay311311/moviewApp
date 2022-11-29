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
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let homeStepper: HomeStepper
    
    init(withStepper steppers: HomeStepper){
        self.homeStepper =  steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        switch step {
        case .home:
            return navigateToHomeScreen()
        case .detail(let id):
            return navigateToDetail(id)
        default:
            return .none
        }
    }
    
    private func navigateToHomeScreen() -> FlowContributors {
        let viewController = HomeViewController(viewModel: HomeViewModel())
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    private func navigateToDetail(_ id:Int) -> FlowContributors {
        let viewController = DetailViewController(viewModel: DetailViewModel(), id:id)
        viewController.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(viewController, animated: false)
        return .none
    }
}

class HomeStepper: Stepper{
    var steps = PublishRelay<Step>()
    

}
