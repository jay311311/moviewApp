//
//  CategoryFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class CategoryFlow: Flow {
    var root: Presentable {
        return self.rooViewController
    }
    
    private let rooViewController = UINavigationController()
//    private let networkService: NetworkService
    private let categoryStepper: CategoryViewModel
    
    init(withStepper steppers: CategoryViewModel) {
//        self.networkService = services
        self.categoryStepper =  steppers
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step  = step as? MainStep else { return .none }
        switch step {
        case .category:
            return navigateToCategoryScreen()
        default:
            return .none
        }
        
    }
    
    func navigateToCategoryScreen() -> FlowContributors {
        let viewController = CategoryViewController(viewModel: categoryStepper)
        self.rooViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: categoryStepper))
    }
    
    
}
