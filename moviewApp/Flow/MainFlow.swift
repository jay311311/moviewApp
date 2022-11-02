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
    
    init() {}
    
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
        case .detail(let id):
            return navigateToDetail(id: id)
        default:
            return .none
        }
    }
    
    private func navigateToLoginScreen() -> FlowContributors {
        let homeStepper = HomeStepper()
        let searchStepper = SearStepper()
        let categoryStepper = CategoryViewModel()
        
        let homeFlow = HomeFlow(withStepper: homeStepper)
        let searchFlow = SearchFlow(withStepper: searchStepper)
        let categoryFlow = CategoryFlow(withStepper: categoryStepper)
        
        Flows.use(homeFlow, searchFlow, categoryFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let homeBtn = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), selectedImage: nil)
            let searchBtn = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
            let categoryBtn = UITabBarItem(title: "Category", image: UIImage.init(systemName: "line.horizontal.3"), selectedImage: nil)
            root1.tabBarItem = homeBtn
            root2.tabBarItem = searchBtn
            root3.tabBarItem = categoryBtn
            self.rootViewController.setViewControllers([root1, root2, root3], animated: false)
        }
        
        return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow,
                                                        withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: MainStep.home), homeStepper])),
                                            .contribute(withNextPresentable: searchFlow,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.search)),
                                            .contribute(withNextPresentable: categoryFlow ,
                                                        withNextStepper: OneStepper(withSingleStep: MainStep.category))
        ])
    }
    
    private func navigateToLogoutScreen() -> FlowContributors {
        return .none
    }
    private func navigateToDetail(id: Int) -> FlowContributors{
        let detailStepper = DetailViewModel()
        let viewController = DetailViewController(viewModel: DetailViewModel(),id: id )
        self.rootViewController.navigationController?.pushViewController(viewController, animated: false)
//        self.rootViewController.pushViewController(viewController, animated: false)
        return .none
    }
}


class MainStepper: Stepper {
    let steps = PublishRelay<Step>()
//    private let networkServices: NetworkService
    
    init() {}
    
    var initialStep: Step {
        return MainStep.loginStatus
    }
}
