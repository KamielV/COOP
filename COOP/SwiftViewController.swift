//
//  SwiftViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 19/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//
// https://www.youtube.com/watch?v=oX9o-DnMHsE pageciewcontroller tutorial

import UIKit

class SwiftViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "page_1"),
                self.VCInstance(name: "page_2"),
                self.VCInstance(name: "page_3"),
                self.VCInstance(name: "page_4")]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = VCArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                let pageBol = view as? UIPageControl
                pageBol?.backgroundColor = UIColor.clear
                pageBol?.pageIndicatorTintColor = UIColor.red
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = VCArray.index(of: viewController) else {
            return nil
        }
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArray.last
        }
        guard VCArray.count > previousIndex else {
            return nil
        }
        
        return VCArray[previousIndex]
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = VCArray.index(of: viewController) else {
            return nil
        }
        let nextIndex = vcIndex + 1
        
        guard nextIndex < VCArray.count else {
            return VCArray.first
        }
        guard VCArray.count > nextIndex else {
            return nil
        }
        
        return VCArray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstVCIndex = VCArray.index(of: firstVC) else {
            return 0
        }
        
        return firstVCIndex
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
