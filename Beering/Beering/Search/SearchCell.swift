//
//  SearchCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/13.
//

import UIKit

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var liquorImage: UIImageView!
    @IBOutlet weak var liquorTitleKor: UILabel!
    @IBOutlet weak var liquorTitleEng: UILabel!
    @IBOutlet weak var breweryTitle: UILabel!
    @IBOutlet weak var isFavorite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
