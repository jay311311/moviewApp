//
//  LatestMovieFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class LatestMovieFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let topRateStepper: LatestMovieStepper
    
    init(withStepper steppers: LatestMovieStepper){
        self.topRateStepper =  steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        switch step {
        case .topRate:
            return  navigateToTopRateScreen()
        default:
            return .none
        }
    }
    
    private func navigateToTopRateScreen() -> FlowContributors {
        let viewController = LatestMovieViewController(viewModel: LatestMovieViewModel())
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}


class LatestMovieStepper: Stepper {
    var steps = PublishRelay<Step>()
    
    var initialStep: Step{
        return MainStep.topRate
    }
}
