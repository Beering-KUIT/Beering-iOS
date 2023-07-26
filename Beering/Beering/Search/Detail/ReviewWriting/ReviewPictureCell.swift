//
//  ReviewPictureCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/26.
//

import UIKit

class ReviewPictureCell: UICollectionViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func removeReviewImageBtnTap(_ sender: Any) {
        
        print("removeReviewImageBtnTap")
    }
    

}
