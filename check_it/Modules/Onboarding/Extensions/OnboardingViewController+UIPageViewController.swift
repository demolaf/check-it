//
//  OnboardingViewController+UIPageViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemsViewController,
              let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllers.count > previousIndex else {
            return nil
        }
        
        return viewControllers[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemsViewController,
              let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = viewControllers.count
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        guard viewControllersCount > nextIndex else {
            return nil
        }
        
        return viewControllers[nextIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = viewControllers.firstIndex(of: currentViewController) {
                pageControl.currentPage = index
            }
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index >= 0 && index < viewControllers.count else {
            return nil
        }
        return viewControllers[index]
    }
    
    func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        pageVC.setViewControllers(
            [viewControllerAtIndex(currentPage)!],
            direction: .forward,
            animated: false
        )
    }
}
