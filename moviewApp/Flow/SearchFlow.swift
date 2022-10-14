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
    
<<<<<<< HEAD
    private let rootViewController = UINavigationController()
    private let networkService: NetworkService
    private let searchStepper: SearchViewModel
    
    init(withService services: NetworkService, withStepper steppers: SearchViewModel){
=======
    private let rootViewController  =  UINavigationController()
    private let networkService : NetworkService
    private let searchStepper : SearchViewModel
    
    init(withService services : NetworkService, withStepper steppers: SearchViewModel){
>>>>>>> 6b45815 (push viewController using RxFlow)
        self.networkService = services
        self.searchStepper =  steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
<<<<<<< HEAD
        guard let step = step as? MainStep else { return .none }
        switch step {
=======
        guard let step  = step as? MainStep  else { return .none }
        
        switch step{
>>>>>>> 6b45815 (push viewController using RxFlow)
        case .search:
            return  navigateToSearchScreen()
        default:
            return .none
        }
    }
    
    private func navigateToSearchScreen() -> FlowContributors {
<<<<<<< HEAD
        let viewController = SearchViewController(viewModel: searchStepper)
=======
        let viewController  =  SearchViewController(viewModel: searchStepper)
>>>>>>> 6b45815 (push viewController using RxFlow)
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: searchStepper))
    }
}
