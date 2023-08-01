//
//  FilterVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/13.
//

import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet var sortOptions: [UIButton]!
    @IBOutlet var filterOptionTitleViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for view in filterOptionTitleViews{
            view.titleViewInit()
        }
        
        for buttonView in sortOptions{
            buttonView.makeCircular()
        }
    }
    

}
