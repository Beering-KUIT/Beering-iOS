//
//  ReviewPreviewCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/18.
//

import UIKit

class ReviewPreviewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var reviewPostedPeriod: UILabel!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var reviewText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
