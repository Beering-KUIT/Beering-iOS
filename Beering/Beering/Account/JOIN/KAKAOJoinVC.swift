//
//  KAKAOJoinVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/11.
//

import UIKit

class KAKAOJoinVC: UIViewController {
    @IBOutlet weak var nikDupliCheckBtn: UIButton!
    @IBOutlet weak var joinMembershipBtn: UIButton!
    @IBOutlet weak var nikTextField: UITextField!
    
    @IBOutlet weak var engCondition: UILabel!
    @IBOutlet weak var korCondition: UILabel!
    @IBOutlet weak var characterLimit: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nikDupliCheckBtnInit()
        joinMembershipBtnInit()
        nikTextFieldInit()
    }
    func nikTextFieldInit(){
        nikTextField.text = "닉네임을 입력해주세요"
        nikTextField.clearButtonMode = .always
        engCondition.text = "영문✓"
        korCondition.text = "한글✓"
        characterLimit.text = "2-8자리✓"
    }
    func nikDupliCheckBtnInit(){
        nikDupliCheckBtn.setTitle("중복체크", for: .normal)
        nikDupliCheckBtn.layer.cornerRadius = 10
        nikDupliCheckBtn.layer.backgroundColor = UIColor(rgb: 0xe2e2e2).cgColor
    }
    func joinMembershipBtnInit(){
        joinMembershipBtn.setTitle("회원가입", for: .normal)
        joinMembershipBtn.layer.cornerRadius = 10
    }

}

