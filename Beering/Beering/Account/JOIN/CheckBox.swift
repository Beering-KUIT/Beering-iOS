//
//  agreementTable.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/20.
//
import Foundation
import UIKit
import SwiftUI

//@IBDesignable // 실시간 랜더링 가능
class CheckBox: UIView{
    //@IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var titleTerms: UILabel!
    @IBOutlet weak var optionTag: UIImageView!
    @IBOutlet weak var displayDetailButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    let checkOnImage = UIImage(systemName: "circle.fill")
    let checkOffImage = UIImage(systemName: "circle")
    var isChecked : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        checkBoxInit()
        checkBoxBtnInit()
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        checkBoxInit()
        checkBoxBtnInit()
    }
       
    private func loadView() {
        //let view = Bundle.main.loadNibNamed("TitleTextField", owner: self, options: nil)?.first as! UIView
        let view = Bundle.main.loadNibNamed("CheckBox", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    private func checkBoxBtnInit(){
        checkBox.tintColor = UIColor(red: 167, green: 167, blue: 167)
        checkBox.setTitle("", for: .normal)
    }
    func changeTitle(termsOfUseTitle: String){
        titleTerms.text = termsOfUseTitle
    }
    
    func checkBoxInit(){
        displayDetailButton.setTitle("", for: .normal)
        optionTag.image = UIImage(named: "NecessaryOption.png")
    }
    func changeOption(optionImage: UIImage){
        optionTag.image = optionImage
    }
    
    @IBAction func checkBoxBtnTap(_ sender: Any) {
        if(isChecked){
            //off
            checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
            checkBox.tintColor = UIColor(red: 167, green: 167, blue: 167)
            isChecked = false
        }
        else{
            //on
            checkBox.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            checkBox.tintColor = UIColor(red: 16, green: 15, blue: 15)
            isChecked = true
        }
    }
    
}
