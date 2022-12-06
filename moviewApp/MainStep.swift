//
//  MainStep.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//

import Foundation
import RxFlow

enum MainStep: Step{
     
    case loginStatus
    case logoutStatus
    
    case home
    case topRate
    case search
    case detail(id: Int)
}


