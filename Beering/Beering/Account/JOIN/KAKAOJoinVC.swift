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
    @IBOutlet weak var nikNameUnderLine: UIView!
    @IBOutlet weak var regExCondition: UILabel!
    //@IBOutlet weak var korCondition: UILabel!
    @IBOutlet weak var characterLimit: UILabel!
    @IBOutlet weak var checkBox1: UIView!
    @IBOutlet weak var termsOfUse1: CheckBox!
    @IBOutlet weak var termsOfUse2: CheckBox!
    @IBOutlet weak var termsOfUse3: CheckBox!
    
    var checkAllTermsOfUse: Bool = false
    var validNikName: Bool = false
    var isDuplicateNik: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nikDupliCheckBtnInit()
        joinMembershipBtnInit()
        nikTextFieldInit()
        termsOfUseInit()
    }
    func termsOfUseInit(){
        //termsOfUse1.changeTitle(termsOfUseTitle: "")
        termsOfUse1.changeTitle(termsOfUseTitle: "첫번째 약관")
        termsOfUse2.changeTitle(termsOfUseTitle: "두번째 약관")
        termsOfUse3.changeTitle(termsOfUseTitle: "세번째 약관")
        termsOfUse3.changeOption(optionImage: UIImage(named: "SelectOption")!)
        termsOfUse1.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        termsOfUse2.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        termsOfUse3.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        //termsOfUse3.agreeButton.addTarget(self, action: #selector(popUpAgreementDetail), for: .touchUpInside)
        termsOfUse1.checkBox.addTarget(self, action: #selector(isCheckedAll), for: .touchUpInside)
        termsOfUse2.checkBox.addTarget(self, action: #selector(isCheckedAll), for: .touchUpInside)
        termsOfUse3.checkBox.addTarget(self, action: #selector(isCheckedAll), for: .touchUpInside)
    }
    func nikTextFieldInit(){
        nikTextField.text = "닉네임을 입력해주세요"
        nikTextField.borderStyle = .none
        //nikTextField.clearButtonMode = .always
        nikTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        nikTextField.addTarget(self, action: #selector(checkRegEx), for: .editingChanged)
        nikTextField.addTarget(self, action: #selector(changeUnderLine), for: .editingChanged)
        nikTextField.addTarget(self, action: #selector(isCheckedAll), for: .editingChanged)
        regExCondition.text = "영문/한글/숫자✓"
        //korCondition.text = "한글✓"
        characterLimit.text = "1-10자리✓"
    }
    func nikDupliCheckBtnInit(){
        nikDupliCheckBtn.setTitle("중복체크", for: .normal)
        nikDupliCheckBtn.layer.cornerRadius = 10
        nikDupliCheckBtn.layer.backgroundColor = Beering.Gray01.cgColor
    }
    func joinMembershipBtnInit(){
        joinMembershipBtn.setTitle("회원가입", for: .normal)
        joinMembershipBtn.layer.cornerRadius = 10
        joinMembershipBtn.backgroundColor = Beering.Gray03
    }
    
    /*@objc func popUpAgreementDetail(){
     let agreementDetail = AgreementDetail(nibName: "AgreementDetail", bundle: nil)
     agreementDetail.modalPresentationStyle = .formSheet
     self.present(agreementDetail, animated: true)
     }*/
    
    func checkNikNameRegEx(inputNikName: String) -> Bool{
        var nikNameRegExCondition: Bool = false
        let nikNameRegEx = "[A-Za-z가-힣0-9]"
        if inputNikName.isEmpty{
            return false
        }
        
        if let regEx = try? NSRegularExpression(pattern: nikNameRegEx, options: .caseInsensitive){
            let results = regEx.matches(in: inputNikName, range: NSRange(location: 0, length: inputNikName.count))
            if results.count == inputNikName.count{
                nikNameRegExCondition = true
            }
            else{
                nikNameRegExCondition = false
            }
        }
        
        return nikNameRegExCondition
    }
    @IBAction func KAKAOjoinBtnTap(_ sender: Any){
        if checkAllTermsOfUse && validNikName{
            let TabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
            let TabBarVC = TabBarStoryboard.instantiateInitialViewController()
            // 메인 화면을 풀 스크린으로 표시
            TabBarVC?.modalPresentationStyle = .fullScreen
            self.present(TabBarVC!, animated: true)
        }
        else{
            print("회원가입 불가")
        }
    }
    @objc func changeUnderLine(){
        if self.nikTextField.text!.count > 0{
            self.nikNameUnderLine.backgroundColor = Beering.Black
        }
        else{
            self.nikNameUnderLine.backgroundColor = Beering.Gray03
        }
    }
    @objc func checkRegEx(){
        regExCondition.text = "영문/한글/숫자✓"
        characterLimit.isHidden = false
        nikTextField.textColor = Beering.Black
        let nikName: String = self.nikTextField.text ?? ""
        var isinRegEx: Bool = false
        //var isinKorean: Bool = false
        var charLimit: Bool = false
        if checkNikNameRegEx(inputNikName: nikName){
            isinRegEx = true
            self.regExCondition.textColor = Beering.Black
        }
        else{
            isinRegEx = false
            self.regExCondition.textColor = Beering.Gray03
        }
        if nikName.count >= 1 && nikName.count <= 10{
            charLimit = true
            self.characterLimit.textColor = Beering.Black
        }
        else {
            charLimit = false
            self.characterLimit.textColor = Beering.Gray03
        }
        
        if isinRegEx && charLimit{
            self.nikDupliCheckBtn.backgroundColor = Beering.Black
            validNikName = true
        }
        else{
            self.nikDupliCheckBtn.backgroundColor = Beering.Gray03
            validNikName = false
        }

    }
    
    @objc func isCheckedAll(){
        if termsOfUse1.isChecked && termsOfUse2.isChecked && validNikName{
            joinMembershipBtn.backgroundColor = Beering.Black
            checkAllTermsOfUse = true
        }
        else{
            joinMembershipBtn.backgroundColor = Beering.Gray03
            checkAllTermsOfUse = false
        }
    }
    
    @objc func displayDetail(){
        let termsOfUseStoryboard = UIStoryboard(name: "TermsOfUse", bundle: nil)
        let termsOfUseVC = termsOfUseStoryboard.instantiateViewController(withIdentifier: "TermsOfUse")
        termsOfUseVC.modalPresentationStyle = .automatic
        termsOfUseVC.view.backgroundColor = UIColor(red: 16, green: 15, blue: 15, alpha: 0.3)
        self.present(termsOfUseVC, animated: true)
    }
    
    @IBAction func nikDuplicateBtnTap(_ seder: Any){
        
        
        if validNikName{
            characterLimit.isHidden = true
            if isDuplicateNik{
                nikNameUnderLine.backgroundColor = Beering.Green
                regExCondition.textColor = Beering.Green
                regExCondition.text = "사용할 수 있는 닉네임이에요"
            }
            else{
                nikNameUnderLine.backgroundColor = Beering.Red
                regExCondition.textColor = Beering.Red
                regExCondition.text = "이미 사용하고 있는 닉네임이에요"
            }
        }
    }
}


