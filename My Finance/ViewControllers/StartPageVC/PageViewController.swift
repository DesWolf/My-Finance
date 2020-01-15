//
//  PageViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/15/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let images = [UIImage(named: "startScreen1"), UIImage(named: "startScreen2"), UIImage(named: "startScreen3"),
                  UIImage(named: "startScreen4"), UIImage(named: "startScreen5"), UIImage(named: "startScreen6"),
                  UIImage(named: "startScreen7")]
  
        override func viewDidLoad() {
            super.viewDidLoad()
            
            dataSource = self

            if let contentPageVC = self.showViewControllerAtIndex(0) {
                setViewControllers([contentPageVC], direction: .forward, animated: true, completion: nil)
            }
        }
        
        func showViewControllerAtIndex(_ index: Int) -> ContentPageViewController? {
            
            guard index >= 0 && index < images.count else {
                let userDefaults = UserDefaults.standard
                userDefaults.set(true, forKey: "appAlreadeSeen")
                dismiss(animated: false, completion: nil)
                return nil
            }
            
            guard let contentPageViewController = storyboard?.instantiateViewController(
                withIdentifier: "ContentPageViewController") as? ContentPageViewController else { return nil }
            
          
            contentPageViewController.currentPage = index
            contentPageViewController.numberOfPages = images.count
            contentPageViewController.presentImage = images[index]
            
            return contentPageViewController
        }
    }

    extension PageViewController: UIPageViewControllerDataSource {
        
    // Переход на одну страницу назад
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            var pageNumber = (viewController as! ContentPageViewController).currentPage
            pageNumber -= 1
            return showViewControllerAtIndex(pageNumber)
        }
        
    // Перход на одну страницу вперед
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            var pageNumber = (viewController as! ContentPageViewController).currentPage
            pageNumber += 1
            return showViewControllerAtIndex(pageNumber)
        }
    }
