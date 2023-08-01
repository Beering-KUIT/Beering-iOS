//
//  HomeVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/05.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var homeProfileImage: UIImageView!
    
    var profileImageArr: [String] = [
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50",
        "https://picsum.photos/50"
    ]
    
    var nicknameArr: [String] = [
    "임윤섭1",
    "임윤섭2",
    "임윤섭3",
    "임윤섭4",
    "임윤섭5",
    "임윤섭6"
    ]
    
    var reviewImages: [[String]] = [
    [],
    ["https://picsum.photos/347"],
    ["https://picsum.photos/347",
     "https://picsum.photos/347"],
    ["https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347"],
    ["https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347"],
    ["https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347",
     "https://picsum.photos/347"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("## HomeVC 진입")
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        let reviewCellNibName = UINib(nibName: "ReviewCell", bundle: nil)
        reviewTableView.register(reviewCellNibName, forCellReuseIdentifier: "reviewCell")
        
        homeProfileImage.makeCircular()
        homeProfileImage.loadImage(from: "https://picsum.photos/333")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

// Review Table View Cell 데이터 삽입
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nicknameArr.count /// TODO Change to Review Data Object Count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.profileImage.loadImage(from: profileImageArr[indexPath.row])
        cell.profileImage.makeCircular()
        cell.nickname.text = nicknameArr[indexPath.row]
//        cell.reviewText.setLineSpacing(spacing: 10)
        
        cell.reviewImageCollectionView.delegate = cell
        cell.reviewImageCollectionView.dataSource = cell
//        cell.reviewImageCollectionView.reloadData()
        
//        print("## reviewImages[indexPath.row] is \(reviewImages[indexPath.row])")
        cell.setReviewImages(reviewImages[indexPath.row])
        cell.setCollectionViewHeight()
        
//        print("## " + cell.nickname.text!)
//        print("## indexPath.row : " + String(indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = UIStoryboard(name: "ReviewDetail", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
}

struct HomeSBPreView:PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!.toPreview()
    }
}

struct HomeVCPreView:PreviewProvider {
    static var previews: some View {
        HomeVC().toPreview()
    }
}

