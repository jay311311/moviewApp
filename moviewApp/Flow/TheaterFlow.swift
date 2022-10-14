//
//  TheaterFlow.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class TheaterFlow : Flow {
    var root: Presentable {
        return self.rooViewController
    }
    
    private let rooViewController = UINavigationController()
    private let networkService : NetworkService
    private let theaterStepper : TheaterViewModel
    
    init(withService services : NetworkService, withStepper steppers: TheaterViewModel){
        self.networkService = services
        self.theaterStepper =  steppers
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step  = step as? MainStep else  { return .none }
        
        switch step {
        case .theater:
            return navigateToTheaterScreen()
        default:
            return    .none
        }
        
    }
    
    func navigateToTheaterScreen() -> FlowContributors {
        let viewController  = TheaterViewController(viewModel: theaterStepper)
        self.rooViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: theaterStepper))
    }
    
    
}
