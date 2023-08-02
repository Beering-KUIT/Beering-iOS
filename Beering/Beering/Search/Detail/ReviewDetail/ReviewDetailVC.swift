//
//  ReviewDetailVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/08/01.
//

import UIKit

class ReviewDetailVC: UIViewController {
    
    var tempImageData:[String] = ["https://picsum.photos/347",
                                  "https://picsum.photos/347",
                                  "https://picsum.photos/347",
                                  "https://picsum.photos/347",
                                  "https://picsum.photos/347"]
    

    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewDetailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewImageCollectionView.dataSource = self
        reviewImageCollectionView.delegate = self
        
        reviewDetailText.textViewInit()
        
        self.tabBarController?.tabBar.isHidden = true

    }
    
}

extension ReviewDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! ReviewImageCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewDetailImageCell", for: indexPath) as! ReviewDetailImageCell
        
        let imageUrl = tempImageData[indexPath.row]
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
