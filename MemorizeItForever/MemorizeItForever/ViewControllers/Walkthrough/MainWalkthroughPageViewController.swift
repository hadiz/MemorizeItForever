//
//  MainWalkthroughPageViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/21/18.
//  Copyright © 2018 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MainWalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private lazy var pages: [UIViewController] = {
        return [getVC(index: 0),
                getVC(index: 1),
                getVC(index: 2)]
    }()
    
    private var pageControl: UIPageControl!
   
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        //setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxX - 50, width: self.view.frame.width, height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            print("##### 1")
            return nil }
        guard previousIndex < pages.count else {
            print("##### 2")
            return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            print("##### 3")
            return nil}
//        guard pages.count > nextIndex else {
//            print("##### 4")
//            return nil }
        return pages[nextIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentVieControlller = self.viewControllers![0]
        pageControl.currentPage = pages.index(of: pageContentVieControlller)!
    }
    
    // MARK: Private Methods
    private func getVC(index: Int) -> UIViewController{
        let storyboard : UIStoryboard = UIStoryboard(name: "Walkthrough",bundle: nil)
        let mainWalkthrough = storyboard.instantiateViewController(withIdentifier: "MainWalkthroughViewController")
        return mainWalkthrough
    }
}
