//
//  ContentPageViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/15/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class ContentPageViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var tutorialImage: UIImageView!

    @IBOutlet var startButton: UIButton!

    var presentImage = UIImage(named: "startScreen1")

    var currentPage = 0
    var numberOfPages = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.isHidden = true
        tutorialImage.image = presentImage
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage

        if pageControl.currentPage == 6 {
            startButton.isHidden = false
        }
    }
}
