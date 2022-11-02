//
//  SearchFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class SearchFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
//    private let networkService: NetworkService
    private let searchStepper: SearStepper
    
    init( withStepper steppers: SearStepper){
//        self.networkService = services
        self.searchStepper =  steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        switch step {
        case .search:
            return  navigateToSearchScreen()
        default:
            return .none
        }
    }
    
    private func navigateToSearchScreen() -> FlowContributors {
        let viewController = SearchViewController(viewModel: SearchViewModel())
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}


class SearStepper: Stepper{
    var steps = PublishRelay<Step>()
    
    var initialStep: Step{
        return MainStep.search
    }
}
