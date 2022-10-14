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

class MainFlow : Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UITabBarController()
    private let networkService : NetworkService
    
    init(withService  services: NetworkService ){
        self.networkService = services
    }
    
    deinit {
        print("이것 전역에 있을꺼여서 절때 deinit될수 없도다")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        
        switch step {
            
        case .loginStatus:
            return navigateToLoginScreen()
        case .logoutStatus:
            return navigateToLogoutScreen()
        default :
            return .none
        }
    }
    
    private func navigateToLoginScreen() -> FlowContributors {
        let homeStepper = HomeViewModel()
        let searchStepper = SearchViewModel()
        let theatherStepper = TheaterViewModel()
        
        let homeFlow = HomeFlow(withService: self.networkService, withStepper: homeStepper)
        let searchFlow = SearchFlow(withService: self.networkService, withStepper: searchStepper)
        let theaterFlow = TheaterFlow(withService: self.networkService, withStepper: theatherStepper)
        
        
        Flows.use(homeFlow, searchFlow, theaterFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let homeBtn = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), selectedImage: nil)
            let searchBtn = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
            let theaterBtn = UITabBarItem(title: "Theater", image: UIImage.init(systemName: "ticket"), selectedImage: nil)
            root1.tabBarItem = homeBtn
//            root1.title = "Home"
            root2.tabBarItem = searchBtn
//            root2.title = "Search"
            root3.tabBarItem = theaterBtn
//            root3.title = "Theater"
            
            self.rootViewController.setViewControllers([root1, root2, root3], animated: false)
        }
        
        return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow,
                                                        withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: MainStep.home), homeStepper])),
                                            .contribute(withNextPresentable: searchFlow,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.search)),
                                            .contribute(withNextPresentable: theaterFlow,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.theater))
        ]
        )
    }
    
    private func navigateToLogoutScreen() -> FlowContributors {
        return .none
    }

}


class MainStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let networkServices: NetworkService
    
    init(withServices services: NetworkService) {
        self.networkServices = services
    }
    
    var initialStep: Step {
        return MainStep.loginStatus
    }
    
}
