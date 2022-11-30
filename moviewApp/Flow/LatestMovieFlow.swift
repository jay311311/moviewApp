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
import SwiftUI

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
        case .detail(let id):
            return navigateToDetail(id)
        default:
            return .none
        }
    }
    
    private func navigateToTopRateScreen() -> FlowContributors {
        let viewController = LatestMovieViewController(viewModel: LatestMovieViewModel())
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    private func navigateToDetail(_ id:Int) -> FlowContributors {
        let viewController =  UIHostingController(rootView: detailViewUI().environmentObject(DetailViewModel(id:id)))
                viewController.hidesBottomBarWhenPushed = true
                self.rootViewController.pushViewController(viewController, animated: false)
        return .none
    }
}


class LatestMovieStepper: RxFlow.Stepper {
    var steps = PublishRelay<Step>()
    
 
}
