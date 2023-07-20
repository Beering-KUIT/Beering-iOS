//
//  NomalJoinVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/11.
//

import UIKit
import SwiftUI

class NomalJoinVC: UIViewController {
    @IBOutlet weak var IDcheckDupliBtn: UIButton!
    @IBOutlet weak var nikDupliCheckBtn: UIButton!
    @IBOutlet weak var joinMembershipBtn: UIButton!
    @IBOutlet weak var IDTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        IDcheckDupliBtnInit()
        nikDupliCheckBtnInit()
        joinMembershipBtnInit()
    }
    
    func IDTextFieldTap(){
        //self.delegate?.textFieldShouldReturn(IDTextField)
    }
    func IDcheckDupliBtnInit(){
        IDcheckDupliBtn.setTitle("중복체크", for: .normal)
        IDcheckDupliBtn.layer.cornerRadius = 10
    }
    func nikDupliCheckBtnInit(){
        nikDupliCheckBtn.setTitle("중복체크", for: .normal)
        nikDupliCheckBtn.layer.cornerRadius = 10
    }
    func joinMembershipBtnInit(){
        joinMembershipBtn.setTitle("회원가입", for: .normal)
        joinMembershipBtn.layer.cornerRadius = 10
    }
    func conditionBtnInit(){
        //conditionToggle1.setTitle("약관 1", for: .normal)
        //conditionBtn2.setTitle("약관 2", for: .normal)
        //conditionBtn3.setTitle("약관 3", for: .normal)
    }
    
    
}
