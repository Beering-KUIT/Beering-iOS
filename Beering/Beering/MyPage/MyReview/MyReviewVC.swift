//
//  MyReviewVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/24.
//

import UIKit

class MyReviewVC: UIViewController {

    @IBOutlet weak var myReviewTableView: UITableView!
    
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
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        
        myReviewTableView.delegate = self
        myReviewTableView.dataSource = self
        
        let myReviewCellNibName = UINib(nibName: "ReviewCell", bundle: nil)
        myReviewTableView.register(myReviewCellNibName, forCellReuseIdentifier: "reviewCell")
        
        navigationBarInit()
    }
    
    private func navigationBarInit(){

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "내 리뷰"
        
        // 커스텀 폰트를 가져옴
        if let customFont = UIFont(name: "Pretendard", size: 16) {
            // 타이틀 텍스트를 NSAttributedString으로 생성하고 폰트를 적용
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .foregroundColor: UIColor(named: "Beering_Black") ?? .black // 폰트 색상 설정
            ]
            self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        }
        
    }
    
    @objc private func goBack(){
        self.navigationController?.popViewController(animated: true)
    }

}

// MyReview Table View Cell 데이터 삽입
extension MyReviewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nicknameArr.count /// TODO Change to Review Data Object Count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.profileImage.loadImage(from: profileImageArr[indexPath.row])
        cell.profileImage.makeCircular()
        cell.nickname.text = nicknameArr[indexPath.row]
        
        cell.reviewImageCollectionView.delegate = cell
        cell.reviewImageCollectionView.dataSource = cell
        
        /// TODO CollectionView 의 높이를 조정하는 것이 아닌, 아예 사라지도록 Refactoring
        if reviewImages[indexPath.row].count > 0{
            cell.setReviewImages(reviewImages[indexPath.row])
            cell.setCollectionViewHeight(208)
        }else{
            cell.setCollectionViewHeight(0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = UIStoryboard(name: "ReviewDetail", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }

}

