//
//  SearchViewModel.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/13.
//
import Foundation
import RxFlow
import RxSwift
import RxCocoa

class SearchViewModel: Stepper  {
    let steps = PublishRelay<Step>()
}

