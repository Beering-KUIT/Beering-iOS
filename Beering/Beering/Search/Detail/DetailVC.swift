//
//  DetailVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/18.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var reviewPreviewTitleView: UIView!
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet var beerStars: [UIImageView]!
    @IBOutlet weak var beerRating: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var beerReviewPeviewCollectionView: UICollectionView!
    
    var beerData = detailData(beerImageUrl: "https://picsum.photos/999", beerTitle: "클라우드", beerRating: 4.8, beerABV: "4.7 %", beerDescription: "1873년 네덜란드에서 탄생한 하이네켄은 190여 개국에서 판매되며 150년간 세계인의 사랑을 받는 글로벌 프리미엄 맥주 브랜드입니다. 보리, 물, 흡 그리고 특별한 효모 A-Yeast 로 이루어진 완벽한 레시피로 한결같이 신선하고 뛰어난 품질을 자랑하는 하이네켄입니다.")
    
    var reviewPreviewData: [reviewPreviewData] = [
        Beering.reviewPreviewData(profileImageUrl: "https://picsum.photos/999", nickname: "다니엘", createdAt: "2주 전", rating: 4.2, reviewText: "이 맥주 정말 맛있지만, 좀 씁쓸해서 먹을까말까먹을까말까 이 맥주 정말 맛있지만, 좀 씁쓸해서 먹을까말까먹을까말까 이 맥주 정말 맛있지만, 좀 씁쓸해서 먹을까말까먹을까말까 이 맥주 정말 맛있지만, 좀 씁쓸해서 먹을까말까먹을까말까"),
        Beering.reviewPreviewData(profileImageUrl: "https://picsum.photos/999", nickname: "sub", createdAt: "3일 전", rating: 4.3, reviewText: "umm very well made beer but too much cream"),
        Beering.reviewPreviewData(profileImageUrl: "https://picsum.photos/999", nickname: "딸기가좋아딸기가좋아", createdAt: "2달 전", rating: 2.3, reviewText: "음 낫배드요음 낫배드요음 낫배드요음 낫배드요"),
        Beering.reviewPreviewData(profileImageUrl: "https://picsum.photos/999", nickname: "수박이좋아수박이좋아딸기가좋아딸기가좋아", createdAt: "12년 전", rating: 4.7, reviewText: "1873년 네덜란드에서 탄생한 하이네켄은 190여 개국에서 판매되며 150년간 세계인의 사랑을 받는 글로벌 프리미엄 맥주 브랜드입니다. 보리, 물, 흡 그리고 특별한 효모 A-Yeast 로 이루어진 완벽한 레시피로 한결같이 신선하고 뛰어난 품질을 자랑하는 하이네켄입니다."),
        Beering.reviewPreviewData(profileImageUrl: "https://picsum.photos/999", nickname: "비어링", createdAt: "3분 전", rating: 4.9, reviewText: "음 낫배드요")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewInit()
        navigationBarInit()
        
        reviewPreviewTitleView.backgroundColor = UIColor(named: "Beering_White")
        reviewPreviewTitleView.addBottomBorderWithColor(color: UIColor.black, width: 1)
        
        
        let reviewPreviewCell = UINib(nibName: "ReviewPreviewCell", bundle: nil)
        beerReviewPeviewCollectionView.register(reviewPreviewCell, forCellWithReuseIdentifier: "reviewPreviewCell")
        
        beerReviewPeviewCollectionView.delegate = self
        beerReviewPeviewCollectionView.dataSource = self
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func detailViewInit(){
        beerImage.loadImage(from: beerData.beerImageUrl)
        beerTitle.text = beerData.beerTitle
        setStarRatingImages(rating: beerData.beerRating, imageViews: beerStars)
        beerRating.text = String(beerData.beerRating)
        beerABV.text = beerData.beerABV + " ABV"
        beerDescription.text = beerData.beerDescription
    }
    
    func setStarRatingImages(rating: Float, imageViews: [UIImageView]) {

        let roundedNumber = (rating * 2).rounded() / 2 // .5 단위 반올림

        for (index, starImage) in imageViews.enumerated() {
            let starIndex = index + 1

            if Float(starIndex) <= roundedNumber{
                    starImage.image = UIImage(named: "star_filled")
            }else{
                if roundedNumber - (Float(starIndex) - 1) == 0.5{
                    starImage.image = UIImage(named: "star_half")
                }else{
                    starImage.image = UIImage(named: "star_blank")
                }
            }
        }
    }
    
    private func navigationBarInit(){
        
        // 네비게이션 바를 투명하게 설정
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

//        // Safe Area의 Top을 0으로 설정하여 네비게이션 바가 스크롤 뷰를 밀어내지 않도록 함
//        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
////        navigationItem.rightBarButtonItem = segmentBarItem
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = leftBarButton
        
        /// TODO 상태에 따른 이미지 교체
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart_blank"), style: .plain, target: self, action: #selector(tapLikeBtn))
        navigationItem.rightBarButtonItem = rightBarButton
//        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart_filled"), style: .plain, target: self, action: #selector(tapLikeBtn))

    }
    @objc private func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func tapLikeBtn(){
        /// TODO
        /// API 호출 및 이미지 교체
        print("heart tap")
    }
    
    @IBAction func reviewBtnTap(_ sender: Any) {
        
        let nextVC = UIStoryboard(name: "Review", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func reviewWritingBtnTap(_ sender: Any) {
        
        let nextVC = UIStoryboard(name: "ReviewWriting", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
}


extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewPreviewData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewPreviewCell", for: indexPath) as! ReviewPreviewCell
        
        cell.profileImage.makeCircular()
        cell.profileImage.loadImage(from: reviewPreviewData[indexPath.row].profileImageUrl)
        cell.nickname.text = reviewPreviewData[indexPath.row].nickname
        cell.reviewPostedPeriod.text = reviewPreviewData[indexPath.row].createdAt
        setStarRatingImages(rating: reviewPreviewData[indexPath.row].rating, imageViews: cell.stars)
        cell.reviewText.text = reviewPreviewData[indexPath.row].reviewText
        
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: (self.reviewImageCollectionView?.frame.width)!, height: (self.reviewImageCollectionView?.frame.height)!)
//    }
}

struct detailData{
    var beerImageUrl: String
    var beerTitle: String
    var beerRating: Float
    var beerABV: String
    var beerDescription: String
}

struct reviewPreviewData{
    var profileImageUrl: String
    var nickname: String
    var createdAt: String
    var rating: Float
    var reviewText: String
}
