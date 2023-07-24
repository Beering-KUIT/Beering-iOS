//
//  ReviewVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/24.
//

import UIKit

class ReviewVC: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!

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
        
        self.navigationController?.navigationBar.isHidden = false
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        let reviewCellNibName = UINib(nibName: "ReviewCell", bundle: nil)
        reviewTableView.register(reviewCellNibName, forCellReuseIdentifier: "reviewCell")
        
        navigationBarInit()
    }
    
    private func navigationBarInit(){

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "리뷰"
        
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
extension ReviewVC: UITableViewDelegate, UITableViewDataSource{
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
        
        cell.setReviewImages(reviewImages[indexPath.row])
        cell.setCollectionViewHeight()
        
        return cell
    }
}

