//
//  WalktroughViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 19/9/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class WalktroughViewController: UIViewController{

    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    
    @IBAction func forwardButtonTaped(sender: UIButton){
        switch index {
        case 0...1:
            let pageViewController = parent as! WalktroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalktrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    var index = 0
    var heading = ""
    var content = ""
    var image = ""
    var pageCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: image)
        pageControl.currentPage = index
        
        if index < pageCount-1 {
            forwardButton.setTitle("NEXT", for: .normal)
        }else{
            forwardButton.setTitle("DONE", for: .normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
