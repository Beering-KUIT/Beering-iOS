//
//  MyPageVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/24.
//

import UIKit

class MyPageVC: UIViewController {
    
    @IBOutlet var settingItemViews: [UIView]!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in settingItemViews{
            view.addBottomBorderWithColor(color: .black, width: 1.0)
        }
        
        profileImage.makeCircular()
        profileImage.loadImage(from: "https://picsum.photos/347")
    }
    


}
