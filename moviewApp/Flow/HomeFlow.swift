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
    
<<<<<<< HEAD
    private let rootViewController = UINavigationController()
    private let networkService: NetworkService
    private let homeStepper: HomeViewModel
    
    init(withService services: NetworkService, withStepper steppers: HomeViewModel){
=======
    private let rootViewController  =  UINavigationController()
    private let networkService : NetworkService
    private let homeStepper : HomeViewModel
    
    init(withService services : NetworkService, withStepper steppers: HomeViewModel){
>>>>>>> 6b45815 (push viewController using RxFlow)
        self.networkService = services
        self.homeStepper = steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep  else { return .none }
        switch step{
        case .home:
            return navigateToHomeScreen()
        case .detail:
            return .none
        default:
            return .none
        }
    }
    
<<<<<<< HEAD
    private func navigateToHomeScreen() -> FlowContributors {
        let viewController = HomeViewController(viewModel: homeStepper)
=======
    private func navigateToHomeScreen() -> FlowContributors{
        let viewController  =  HomeViewController(viewModel: homeStepper)
//        viewController.title = viewController.mainTitle.text
>>>>>>> 6b45815 (push viewController using RxFlow)
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: homeStepper))
    }
}

