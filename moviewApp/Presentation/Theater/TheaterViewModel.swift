//
//  TheaterViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//
import Foundation
import RxFlow
import RxSwift
import RxCocoa

class TheaterViewModel: Stepper  {
    let steps = PublishRelay<Step>()
}

