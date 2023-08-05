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
    @IBOutlet weak var isFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateIsFavoriteImage(){
        
        if isFavorite.isSelected{
            self.isFavorite.setImage(UIImage(named: "heart_filled"), for: .normal)
        }else{
            self.isFavorite.setImage(UIImage(named: "heart_blank"), for: .normal)
        }
    }

}
