//
//  HomeMainSlideViewController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/10/27.
//
import UIKit
import Foundation

class HomeMainSlideViewController: UIPageViewController, UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = slideViewControllers.first{
            self.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        setupLayout()
    }

    lazy var pageControls:UIPageControl = {
       let controls =  UIPageControl()
        return controls
    }()
    lazy var slideViewControllers: [UIViewController] = {
        lazy var vc1: UIViewController = {
            let vc  =  UIViewController()
            vc.view.backgroundColor = .blue
            return vc
        }()
        
        lazy var vc2: UIViewController = {
            let vc  =  UIViewController()
            vc.view.backgroundColor = .red
            return vc
        }()
        
        lazy var vc3: UIViewController = {
            let vc  =  UIViewController()
            vc.view.backgroundColor = .yellow
            return vc
        }()
        
        lazy var vc4: UIViewController = {
            let vc  =  UIViewController()
            vc.view.backgroundColor = .purple
            return vc
        }()
       return [vc1,vc2,vc3,vc4]
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        view.addSubview(pageControls)
        pageControls.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HomeMainSlideViewController{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = slideViewControllers.firstIndex(of: viewController) else { return nil}
        let previousIndex =  index - 1
        guard previousIndex >= 0 else { return slideViewControllers.last }
        guard slideViewControllers.count > previousIndex else { return nil }
        return slideViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = slideViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        let viewControllersCount = slideViewControllers.count
        guard viewControllersCount != nextIndex else { return slideViewControllers.first }
        guard viewControllersCount > nextIndex else { return nil }
        return slideViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageControls.numberOfPages =  slideViewControllers.count
        return slideViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,let firstViewControllerIndex = slideViewControllers.firstIndex(of: firstViewController) else { return 0 }
        pageControls.currentPage =  firstViewControllerIndex
        return firstViewControllerIndex
    }
    
    func setupPageControls(){
        
    }
}

