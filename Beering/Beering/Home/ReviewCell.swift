//
//  ReviewCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/05.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
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
    func setCollectionViewHeight(){
        self.reviewImageCollectionView.heightAnchor.constraint(equalToConstant: 208).isActive = true
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
