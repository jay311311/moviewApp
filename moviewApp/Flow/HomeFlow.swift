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

class HomeFlow : Flow {

    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController  =  UINavigationController()
    private let networkService : NetworkService
    private let homeStepper : HomeStepper
    
    init(withService services : NetworkService, withStepper steppers: HomeStepper){
        self.networkService = services
        self.homeStepper =  steppers
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step  = step as? MainStep  else { return .none }
        
        switch step{
            
        case .home:
            return  navigateToHomeScreen()
        case .detail:
            return .none
        default :
            return .none
        }
    }
    
    private func navigateToHomeScreen() -> FlowContributors{
        let viewController  =  HomeViewController()
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: HomeStepper()))
    }
}

class HomeStepper : Stepper {
    let steps = PublishRelay<Step>()

    let initialStep: Step =  MainStep.home
    
    
}
