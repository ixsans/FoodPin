//
//  WalktroughPageViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 21/9/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class WalktroughPageViewController: UIPageViewController, UIPageViewControllerDataSource  {
    
    var pageHeading = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = ["Pin your favorite restaurants and create your own food guide",
                       "Search and locate your favorite restaurant on Maps",
                       "Find restaurants pinned by your friend and other foodies"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        
        if let staringViewController = contentViewController(at: 0){
            setViewControllers([staringViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalktroughViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalktroughViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func forward(index:Int){
        if let pageViewController = contentViewController(at: index+1){
            setViewControllers([pageViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func contentViewController(at index: Int) -> WalktroughViewController?{
        if (index < 0 || index >= pageContent.count){
            return nil
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalktroughContentViewController") as? WalktroughViewController{
            
            pageViewController.image = pageImages[index]
            pageViewController.content = pageContent[index]
            pageViewController.heading = pageHeading[index]
            pageViewController.index = index
            
            return pageViewController
        }
        
        return nil
    }
    
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return pageContent.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalktroughContentViewController") as? WalktroughViewController{
//            return pageViewController.index
//        }
//        return 0
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
