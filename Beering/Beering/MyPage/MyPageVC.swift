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
            view.titleViewInit()
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Beering_White")
        
        profileImage.makeCircular()
//        profileImage.loadImage(from: "https://picsum.photos/347")
        profileImage.image = UIImage(named: "user_profile_default")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func myReviewBtnTap(_ sender: Any) {
        
        let nextVC = UIStoryboard(name: "MyReview", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func likedReviewBtnTap(_ sender: Any) {
        
        let nextVC = UIStoryboard(name: "LikedReview", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func myLiquorBtnTap(_ sender: Any) {
        
        let nextVC = UIStoryboard(name: "MyLiquor", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
}
