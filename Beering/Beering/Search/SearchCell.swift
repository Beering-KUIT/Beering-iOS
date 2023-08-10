//
//  SearchCell.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/13.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func reloadFavoriteData(_ index: Int, _ isSelected: Bool)
}

class SearchCell: UICollectionViewCell {
    
    weak var delegate: SearchCellDelegate?
    var index: Int?

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
            isFavorite.setImage(UIImage(named: "heart_filled"), for: .normal)
        }else{
            isFavorite.setImage(UIImage(named: "heart_blank"), for: .normal)
        }
    }
    
    @IBAction func isFavoriteBtnTap(_ sender: Any) {
        
        print("who is delegate ? : \(delegate)")
        isFavorite.isSelected = !isFavorite.isSelected
        updateIsFavoriteImage()
        
        delegate?.reloadFavoriteData(index!, isFavorite.isSelected)
    }

}
