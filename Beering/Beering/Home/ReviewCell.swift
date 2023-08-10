//
//  ReviewCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/05.
//

import UIKit

protocol ReviewCellDelegate: AnyObject {
    func reloadReviewGoodOrBadData(_ index: Int, _ isGood: Bool, _ isBad: Bool)
}

class ReviewCell: UITableViewCell {
    
    weak var delegate: ReviewCellDelegate?
    var index: Int?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
        
    @IBOutlet weak var creatdAt: UILabel!
    
    @IBOutlet weak var isGoodReviewBtn: UIButton!
    @IBOutlet weak var isGoodCount: UILabel!
    
    @IBOutlet weak var isBadReviewBtn: UIButton!
    @IBOutlet weak var isBadCount: UILabel!
    
    @IBOutlet weak var reviewText: UILabel!
    
    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
    
    var reviewImages: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let reviewImageCellNibName = UINib(nibName: "ReviewImageCell", bundle: nil)
        reviewImageCollectionView.register(reviewImageCellNibName, forCellWithReuseIdentifier: "reviewImageCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setReviewImages(_ images: [String]){
        // 리뷰 이미지 정보를 사용하여 UICollectionView를 업데이트
        self.reviewImages = images
        self.reviewImageCollectionView.reloadData()
    }
    
    // 이미지뷰 크기 지정
    /// TODO 이미지 개수 0개이면 높이 0으로
    func setCollectionViewHeight(_ constant: CGFloat){
        self.reviewImageCollectionView.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func updateIsGoodOrBadReviewImage(){
        
        if isGoodReviewBtn.isSelected{
            isGoodReviewBtn.setImage(UIImage(named: "like_filled"), for: .normal)
            isBadReviewBtn.setImage(UIImage(named: "dislike_blank"), for: .normal)
        }else if isBadReviewBtn.isSelected{
            isGoodReviewBtn.setImage(UIImage(named: "like_blank"), for: .normal)
            isBadReviewBtn.setImage(UIImage(named: "dislike_filled"), for: .normal)
        }else{
            isGoodReviewBtn.setImage(UIImage(named: "like_blank"), for: .normal)
            isBadReviewBtn.setImage(UIImage(named: "dislike_blank"), for: .normal)
        }
    }
    
    @IBAction func isGoodReviewBtnTap(_ sender: Any) {
        
        isGoodReviewBtn.isSelected = !isGoodReviewBtn.isSelected
        isBadReviewBtn.isSelected = false
        updateIsGoodOrBadReviewImage()
        
        delegate?.reloadReviewGoodOrBadData(index!, isGoodReviewBtn.isSelected, isBadReviewBtn.isSelected)
    }
    
    @IBAction func isBadReviewBtnTap(_ sender: Any) {
        
        isBadReviewBtn.isSelected = !isBadReviewBtn.isSelected
        isGoodReviewBtn.isSelected = false
        updateIsGoodOrBadReviewImage()
        
        delegate?.reloadReviewGoodOrBadData(index!, isGoodReviewBtn.isSelected, isBadReviewBtn.isSelected)
    }
    
}

extension ReviewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! ReviewImageCell
        
        let imageUrl = reviewImages[indexPath.row]
//        print("## collectionView indexPath.section : \(String(indexPath.section)) and indexPath.row : \(indexPath.row)")
//        print("## URL is \(imageUrl)")
        cell.reviewImage.loadImage(from: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        print("resize image cell width : \((self.reviewImageCollectionView?.frame.width)!)")
//        print("resize image cell height : \((self.reviewImageCollectionView?.frame.height)!)")
        return CGSize(width: (self.reviewImageCollectionView?.frame.width)!, height: (self.reviewImageCollectionView?.frame.height)!)
    }
}
