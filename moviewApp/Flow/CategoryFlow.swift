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
        return self.rooViewController
    }
    
    private let rooViewController = UINavigationController()
    private let categoryStepper: SearchStepper
    
    init(withStepper steppers: SearchStepper) {
        self.categoryStepper = steppers
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        switch step {
        case .search:
            return navigateToSearchScreen()
        default:
            return .none
        }
    }
    
    func navigateToSearchScreen() -> FlowContributors {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: viewModel)
        self.rooViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}

class SearchStepper: Stepper {
    var steps = PublishRelay<Step>()

}
