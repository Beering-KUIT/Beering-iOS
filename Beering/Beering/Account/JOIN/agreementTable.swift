//
//  agreementTable.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/20.
//

import SwiftUI

class agreementTable: UIButton{
    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var titleTerms: UILabel!
    @IBOutlet weak var optionTag: UIImageView!
    
    func changeTitle(termsOfUseTitle: String){
        titleTerms.text = termsOfUseTitle
    }
    
    func changeOption(optionImage: UIImage){
        optionTag.image = optionImage
    }
    
    @IBAction func agreementBtnTap(_ sender: Any) {
        let beforeCheck = UIImage(systemName: "circle")
        let afterCheck = UIImage(systemName: "circle.fill")
        if(checkbox == beforeCheck){
            checkbox.image = afterCheck
            checkbox.tintColor = UIColor.black
        }
        else{
            checkbox.image = beforeCheck
            checkbox.tintColor = UIColor.gray
        }
    }
    
}
