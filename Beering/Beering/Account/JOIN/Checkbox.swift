//
//  Checkbox.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/12.
//

import SwiftUI
class Checkbox: UIButton{
    @IBOutlet weak var checkbox: UIButton!
    
    //var deligate: CheckBoxDelegate?
    /*func checkboxInit(){
        checkbox.addTarget(self, action: #selector(checkBoxTap), for: .touchUpInside)
    }
    @objc func checkBoxTap(){
        if let checkImage = UIImage(named: "circle.fill") {
            checkbox.setImage(checkImage, for: .normal)
            //checkbox.setImage(checkImage, forState: .Normal)
        }
    }*/
    @IBAction func checkboxBtnTap(_ sender: Any) {
        let beforeCheck = UIImage(systemName: "circle")
        let afterCheck = UIImage(systemName: "circle.fill")
        if (checkbox.currentImage == beforeCheck) {
            checkbox.setImage(afterCheck, for: .normal)
            checkbox.tintColor = UIColor.black
        }
        else{
            checkbox.setImage(beforeCheck, for: .normal)
            checkbox.tintColor = UIColor.gray
        }
    }
}
