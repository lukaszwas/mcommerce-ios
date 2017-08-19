//
//  ImagesViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 15.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit
import AlamofireImage

class ImagesViewController: UIPageViewController, UIPageViewControllerDataSource {

    var images: [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
    }
    
    func updateView() {
        self.setViewControllers([viewControllerAtIndex(index: 0)!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: ImagesItemViewController = viewController as! ImagesItemViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index = index + 1;
        var count = 1
        if (self.images != nil) {
            count = (self.images?.count)!
        }
        if (index == count)
        {
            return nil;
        }
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: ImagesItemViewController = viewController as! ImagesItemViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index = index - 1;
        return viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        let pageContentViewController: ImagesItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImagesItemViewController") as! ImagesItemViewController
        pageContentViewController.pageIndex = index
        
        if (index < (self.images?.count)!) {
            pageContentViewController.image = self.images?[index]
        }
        else {
            pageContentViewController.image = ""
        }
        
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
