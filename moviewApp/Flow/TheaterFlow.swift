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
    private let theaterStepper : TheaterStepper
    
    init(withService services : NetworkService, withStepper steppers: TheaterStepper){
        self.networkService = services
        self.theaterStepper =  steppers
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step  = step as? MainStep else  { return .none }
        
        switch step {
        case .theater:
            let viewController  = TheaterViewController()
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: TheaterStepper()))
            
        default:
            return    .none
        }
        
    }
    
    
}
class TheaterStepper : Stepper {
    let steps = PublishRelay<Step>()
    
    let initialStep: Step =  MainStep.theater
    
    
}
