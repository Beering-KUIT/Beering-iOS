//
//  ReviewPictureCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/26.
//

import UIKit

class ReviewPictureCell: UICollectionViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    var indexPath: IndexPath?
    weak var delegate: ReviewPictureCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func removeReviewImageBtnTap(_ sender: Any) {
        
        print("removeReviewImageBtnTap")
        print("indexPath : \(indexPath)")
        if let indexPath = indexPath {
            delegate?.didTapRemoveButton(at: indexPath)
        }
    }
    
}

protocol ReviewPictureCellDelegate: AnyObject {
    func didTapRemoveButton(at indexPath: IndexPath)
}
