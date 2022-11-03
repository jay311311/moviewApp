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
    private let categoryStepper: CategoryStepper
    
    init(withStepper steppers: CategoryStepper) {
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
        let viewController = CategoryViewController(viewModel: CategoryViewModel())
        self.rooViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    
}


class CategoryStepper:Stepper{
    var steps = PublishRelay<Step>()
    
    
    var initialStep: Step{
        return MainStep.category
    }
}
