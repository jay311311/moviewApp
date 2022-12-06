//
//  MainFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class MainFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UITabBarController()
    
    init() { }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        switch step {
        case .loginStatus:
            return navigateToLoginScreen()
        case .logoutStatus:
            return navigateToLogoutScreen()
        default:
            return .none
        }
    }
    
    private func navigateToLoginScreen() -> FlowContributors {
        lazy var homeStepper = HomeStepper()
        lazy var latestStepper = LatestMovieStepper()
        lazy var searchStepper = SearchStepper()
        
        lazy var homeFlow = HomeFlow(withStepper: homeStepper)
        lazy var latestFlow = LatestMovieFlow(withStepper: latestStepper)
        lazy var searchFlow = SearchFlow(withStepper: searchStepper)

        
        
        Flows.use(homeFlow, latestFlow, searchFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let homeBtn = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), selectedImage: nil)
            let searchBtn = UITabBarItem(title: "Latest", image: UIImage.init(systemName: "star"), selectedImage: nil)
            let categoryBtn = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
            root1.tabBarItem = homeBtn
            root2.tabBarItem = searchBtn
            root3.tabBarItem = categoryBtn
            self.rootViewController.setViewControllers([root1, root2, root3], animated: false)
        }
        
        return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.home)),
                                            .contribute(withNextPresentable: latestFlow,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.topRate)),
                                            .contribute(withNextPresentable: searchFlow,
                                                        withNextStepper: OneStepper(withSingleStep:MainStep.search))
        ])
    }
    
    private func navigateToLogoutScreen() -> FlowContributors {
        return .none
    }
}


class MainStepper: Stepper {
    let steps = PublishRelay<Step>()
    init() {}
    
    var initialStep: Step {
        return MainStep.loginStatus
    }
}
