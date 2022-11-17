//
//  HomeMainSlideViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/27.
//
import UIKit
import Foundation
import RxCocoa
import RxSwift

class HomeMainSlideViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    let weeklyMovieSlide = BehaviorRelay<[AllInfo]>(value: [])
    var slideViewControllerList: [MainSlideViewController] = []
    let actionRelay = PublishRelay<HomeActionType>()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
    }
    func setPageViewList() {
        for list in weeklyMovieSlide.value {
            guard let vc = MainSlideViewController(movieTitle: list.title, posterURL: list.poster_path, overview:list.overview, movieId: list.id) else { return }
            vc.setupDI(actionRelay: actionRelay)
            slideViewControllerList.append(vc)
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        setPageViewList()
        if let firstVC = slideViewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func setupDI(observable: BehaviorRelay<[AllInfo]>) {
        observable.bind(to: weeklyMovieSlide).disposed(by: disposeBag)
    }
    /// 액션 연결.
    func setupDI(relay: PublishRelay<HomeActionType>) {
        actionRelay.bind(to: relay).disposed(by: disposeBag)
    }
}

extension HomeMainSlideViewController {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = slideViewControllerList.firstIndex(of: viewController as! MainSlideViewController) else { return nil}
        let previousIndex = index - 1
        guard previousIndex >= 0 else { return slideViewControllerList.last }
        guard slideViewControllerList.count > previousIndex else { return nil }
        return slideViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = slideViewControllerList.firstIndex(of: viewController as! MainSlideViewController) else { return nil }
        let nextIndex = index + 1
        let viewControllersCount = slideViewControllerList.count
        guard viewControllersCount != nextIndex else { return slideViewControllerList.first }
        guard viewControllersCount > nextIndex else { return nil }
        return slideViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return slideViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,let firstViewControllerIndex = slideViewControllerList.firstIndex(of: firstViewController as! MainSlideViewController) else { return 0 }
        return firstViewControllerIndex
    }
}

