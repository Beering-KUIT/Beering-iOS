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
    
    var tempData: [reviewCellInfo] = [
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭", createdAt: "1주전", isGood: true, isGoodCount: 301, isBadCount: 209, reviewImageUrls: [], reviewText: "너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 너무좋아요 "),
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭1", createdAt: "2주전", isGood: false, isGoodCount: 302, isBadCount: 208, reviewImageUrls: ["https://picsum.photos/347"], reviewText: "사법권은 법관으로 구성된 법원에 속한다. 대법관의 임기는 6년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다. 언론·출판은 타인의 명예나 권리 또는 공중도덕이나 사회윤리를 침해하여서는 아니된다. 언론·출판이 타인의 명예나 권리를 침해한 때에는 피해자는 이에 대한 피해의 배상을 청구할 수 있다. 헌법재판소는 법률에 저촉되지 아니하는 범위안에서 심판에 관한 절차, 내부규율과 사무처리에 관한 규칙을 제정할 수 있다. 국가는 사회보장·사회복지의 증진에 노력할 의무를 진다."),
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭2", createdAt: "3주전", isGood: true, isGoodCount: 303, isBadCount: 207, reviewImageUrls: ["https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347"], reviewText: "정기회의 회기는 100일을, 임시회의 회기는 30일을 초과할 수 없다."),
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭3", createdAt: "4주전", isGood: true, isGoodCount: 304, isBadCount: 206, reviewImageUrls: ["https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347"], reviewText: "대통령은 내우·외환·천재·지변 또는 중대한 재정·경제상의 위기에 있어서 국가의 안전보장 또는 공공의 안녕질서를 유지하기 위하여 긴급한 조치가 필요하고 국회의 집회를 기다릴 여유가 없을 때에 한하여 최소한으로 필요한 재정·경제상의 처분을 하거나 이에 관하여 법률의 효력을 가지는 명령을 발할 수 있다.대통령은 법률에서 구체적으로 범위를 정하여 위임받은 사항과 법률을 집행하기 위하여 필요한 사항에 관하여 대통령령을 발할 수 있다. 사법권은 법관으로 구성된 법원에 속한다."),
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭4", createdAt: "5주전", isGood: false, isGoodCount: 305, isBadCount: 205, reviewImageUrls: [], reviewText: "쩝 맛있네요"),
        reviewCellInfo(profileImageUrl: "https://picsum.photos/50", nickname: "임윤섭5", createdAt: "6주전", isGood: true, isGoodCount: 306, isBadCount: 204, reviewImageUrls: ["https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347",
                                                                                                                                                             "https://picsum.photos/347"], reviewText: "요"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("#############accessToken#############")
        print(KeyChain.retrieve(account: "BeeringAccessToken"))
        // Do any additional setup after loading the view.
        print("## HomeVC 진입")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Beering_White")
        
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource, ReviewCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count /// TODO Change to Review Data Object Count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.index = indexPath.row
        cell.delegate = self
        
        cell.profileImage.loadImage(from: tempData[indexPath.row].profileImageUrl)
        cell.profileImage.makeCircular()
        
        cell.nickname.text = tempData[indexPath.row].nickname
//        cell.reviewText.setLineSpacing(spacing: 10)
        
        cell.creatdAt.text = tempData[indexPath.row].createdAt
        
        if let isGood = tempData[indexPath.row].isGood{
            if isGood{
                cell.isGoodReviewBtn.setImage(UIImage(named: "like_filled"), for: .normal)
            }else{
                cell.isBadReviewBtn.setImage(UIImage(named: "dislike_filled"), for: .normal)
            }
        }
        
        cell.isGoodCount.text = String(tempData[indexPath.row].isGoodCount)
        cell.isBadCount.text = String(tempData[indexPath.row].isBadCount)
        
        cell.reviewText.text = tempData[indexPath.row].reviewText
        
        cell.reviewImageCollectionView.delegate = cell
        cell.reviewImageCollectionView.dataSource = cell
//        cell.reviewImageCollectionView.reloadData()
        
//        print("## reviewImages[indexPath.row] is \(reviewImages[indexPath.row])")
        
        /// TODO CollectionView 의 높이를 조정하는 것이 아닌, 아예 사라지도록 Refactoring
        if tempData[indexPath.row].reviewImageUrls.count > 0{
            cell.setReviewImages(tempData[indexPath.row].reviewImageUrls)
            cell.setCollectionViewHeight(208)
        }else{
            cell.setCollectionViewHeight(0)
        }
        
//        print("## " + cell.nickname.text!)
//        print("## indexPath.row : " + String(indexPath.row))
        
        return cell
    }
    
    // 👍 👎 Click 시의, SearchCellDelegate 구현 메서드
    func reloadReviewGoodOrBadData(_ index: Int, _ isGood: Bool, _ isBad: Bool) {
        
        if isGood == false && isBad == false{
            tempData[index].isGood = nil
        }else if isGood == true{
            tempData[index].isGood = true
        }else{
            tempData[index].isGood = false
        }
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

struct reviewCellInfo{
    var profileImageUrl: String
    var nickname: String
    var createdAt: String
    var isGood: Bool?
    var isGoodCount: Int
    var isBadCount: Int
    var reviewImageUrls: [String]
    var reviewText: String
}
