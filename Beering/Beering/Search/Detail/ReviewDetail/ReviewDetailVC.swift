//
//  ReviewDetailVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/08/01.
//

import UIKit

class ReviewDetailVC: UIViewController {
    
    var tempReviewDatas: tempReviewData = tempReviewData(imageUrl: ["https://picsum.photos/347",
                                                                    "https://picsum.photos/347",
                                                                    "https://picsum.photos/347",
                                                                    "https://picsum.photos/347",
                                                                    "https://picsum.photos/347"], userProfileImageUrl: "https://picsum.photos/347",
                                                         userNickName: "비어링 유저", createdAt: "2023년 8월 11일", reviewText: "맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 맛있어요 ", totalScore: 4.5, tasteScore: 4.0, aromaScore: 0.5, colorScore: 0.0, swallowingScore: 3.0)
    
    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var reviewDetailText: UITextView!
    
    
    @IBOutlet var totalScoreStars: [UIImageView]!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    
    @IBOutlet var tasteScoreStars: [UIImageView]!
    @IBOutlet weak var tasteScoreLabel: UILabel!
    
    @IBOutlet var aromaScoreStars: [UIImageView]!
    @IBOutlet weak var aromaScoreLabel: UILabel!
    
    
    @IBOutlet var colorScoreStars: [UIImageView]!
    @IBOutlet weak var colorScoreLabel: UILabel!
    
    
    @IBOutlet var swallowingScoreStars: [UIImageView]!
    @IBOutlet weak var swallowingScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewImageCollectionView.dataSource = self
        reviewImageCollectionView.delegate = self
        
        layoutInit()
        
        reviewDetailText.textViewInit()
        navigationBarInit()
        
        self.tabBarController?.tabBar.isHidden = true

    }
    
    func layoutInit(){
        
        if let userProfileImageUrl = tempReviewDatas.userProfileImageUrl{
            userProfileImage.makeCircular()
            userProfileImage.loadImage(from: userProfileImageUrl)
        }else{
            userProfileImage.image = UIImage(named: "user_profile_default")
        }
        
        userNicknameLabel.text = tempReviewDatas.userNickName
        createdAtLabel.text = tempReviewDatas.createdAt
        reviewDetailText.text = tempReviewDatas.reviewText
        
        /// TODO
        /// 배열 등으로 관리하기
        starInit(totalScoreStars, tempReviewDatas.totalScore)
        starInit(tasteScoreStars, tempReviewDatas.tasteScore)
        starInit(aromaScoreStars, tempReviewDatas.aromaScore)
        starInit(colorScoreStars, tempReviewDatas.colorScore)
        starInit(swallowingScoreStars, tempReviewDatas.swallowingScore)
        
        
        totalScoreLabel.text = String(tempReviewDatas.totalScore)
        tasteScoreLabel.text = String(tempReviewDatas.tasteScore)
        aromaScoreLabel.text = String(tempReviewDatas.aromaScore)
        colorScoreLabel.text = String(tempReviewDatas.colorScore)
        swallowingScoreLabel.text = String(tempReviewDatas.swallowingScore)
        
    }
    
    func starInit(_ imageViews: [UIImageView], _ score: Float){

        for index in 0..<Int(floor(score)){
            if let starImage = imageViews[index] as? UIImageView {
                starImage.image = UIImage(named: "star_filled")
            }
        }
        for index in Int(floor(score))..<5{
            if let starImage = imageViews[index] as? UIImageView {
                starImage.image = UIImage(named: "star_blank")
            }
        }
        if score - floor(score) == 0.5{
            if let starImage = imageViews[ Int(floor(score))] as? UIImageView {
                starImage.image = UIImage(named: "star_half")
            }
        }
        
    
    }
    
    private func navigationBarInit(){
        
        // 네비게이션 바를 투명하게 설정
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = .clear

//        // Safe Area의 Top을 0으로 설정하여 네비게이션 바가 스크롤 뷰를 밀어내지 않도록 함
//        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
////        navigationItem.rightBarButtonItem = segmentBarItem
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Beering_Black")
                
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = leftBarButton
        
        /// TODO 상태에 따른 이미지 교체
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(ellipsisBtnTap))
        navigationItem.rightBarButtonItem = rightBarButton
        
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
    
    @objc func ellipsisBtnTap(){
        /// TODO
        /// API 호출
        
        // 메시지창 컨트롤러 인스턴스 생성
//        let alert = UIAlertController(title: "사진 업로드", message: "업로드 방식을 선택해주세요", preferredStyle: UIAlertController.Style.actionSheet)
        let alert = UIAlertController()

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let editReviewAction =  UIAlertAction(title: "수정하기", style: UIAlertAction.Style.default){ [weak self] _ in
            print("수정하기 API 호출 요청")
        }
        let deleteReviewAction =  UIAlertAction(title: "삭제하기", style: UIAlertAction.Style.destructive){ [weak self] _ in
            print("삭제하기 API 호출 요청")
        }
        let cancleAction =  UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel){ [weak self] _ in
            print("취소")
        }
        
        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(editReviewAction)
        alert.addAction(deleteReviewAction)
        alert.addAction(cancleAction)

        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: true)
    }
    
}

extension ReviewDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempReviewDatas.imageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! ReviewImageCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewDetailImageCell", for: indexPath) as! ReviewDetailImageCell
        
        let imageUrl = tempReviewDatas.imageUrl[indexPath.row]
        cell.reviewDetailImageView.loadImage(from: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        return CGSize(width: (self.reviewImageCollectionView?.frame.width)!, height: (self.reviewImageCollectionView?.frame.height)!)
        return CGSize(width: reviewImageCollectionView.frame.width, height: reviewImageCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

struct tempReviewData{
    var imageUrl: [String]
    var userProfileImageUrl: String?
    var userNickName: String
    var createdAt: String
    var reviewText: String
    var totalScore: Float
    var tasteScore: Float
    var aromaScore: Float
    var colorScore: Float
    var swallowingScore: Float
}
