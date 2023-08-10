//
//  NomalJoinVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/11.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire

class NormalJoinVC: UIViewController {
    @IBOutlet weak var IDcheckDupliBtn: UIButton!
    @IBOutlet weak var nikDupliCheckBtn: UIButton!
    @IBOutlet weak var joinMembershipBtn: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var IDTextFieldUnderLine: UIView!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var duplicateIDText: UILabel!
    @IBOutlet weak var passwordTextFieldUnderLine: UIView!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var nikNameTextField: UITextField!
    @IBOutlet weak var nikNameTextFieldUnderLine: UIView!
    
    @IBOutlet weak var confirmInvisibleMode: UIButton!
    @IBOutlet weak var passwordInvisibleMode: UIButton!
    @IBOutlet weak var confirmPasswordUnderLine: UIView!
    @IBOutlet weak var differentPasswordText: UILabel!
    
    @IBOutlet weak var nikNameRegEx: UILabel!
    @IBOutlet weak var nikNameCharLimit: UILabel!
    @IBOutlet weak var passwordEngRegEx: UILabel!
    @IBOutlet weak var passwordSpecialRegEx: UILabel!
    @IBOutlet weak var passwordNumRegEx: UILabel!
    @IBOutlet weak var passwordCharLimit: UILabel!
    
    @IBOutlet weak var termsOfUse1: CheckBox!
    @IBOutlet weak var termsOfUse2: CheckBox!
    @IBOutlet weak var termsOfUse3: CheckBox!
    
    var validNikName: Bool = false
    var validID: Bool = false
    var validPassword: Bool = false
    var validJoin: Bool = false
    var samePassword: Bool = true
    
    var isDuplicateID: Bool = false
    var isDuplicatePassword: Bool = false
    var isDuplicateNik: Bool = false
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDcheckDupliBtnInit()
        nikDupliCheckBtnInit()
        joinMembershipBtnInit()
        textFieldInit()
        termsOfUseInit()
    }
    
    func textFieldInit(){
        IDTextField.text = "아이디를 입력해주세요(이메일 형식)"
        IDTextField.textColor = Beering.Gray01
        IDTextField.borderStyle = .none
        IDTextFieldUnderLine.backgroundColor = Beering.Gray01
        duplicateIDText.isHidden = true
        confirmPasswordUnderLine.backgroundColor = Beering.Gray01
        
        passwordTextField.borderStyle = .none
        confirmPassword.borderStyle = .none
        confirmPassword.textColor = Beering.Gray01
        passwordCharLimit.textColor = Beering.Gray01
        passwordEngRegEx.textColor = Beering.Gray01
        passwordNumRegEx.textColor = Beering.Gray01
        passwordSpecialRegEx.textColor = Beering.Gray01
        passwordTextFieldUnderLine.backgroundColor = Beering.Gray01
        passwordTextField.textColor = Beering.Gray01
        
        //추가
        passwordTextField.isSecureTextEntry = false
        confirmPassword.isSecureTextEntry = false
        passwordInvisibleMode.setTitle("", for: .normal)
        confirmInvisibleMode.setTitle("", for: .normal)
        
        
        nikNameTextField.borderStyle = .none
        nikNameRegEx.textColor = Beering.Gray01
        nikNameCharLimit.textColor = Beering.Gray01
        nikNameTextFieldUnderLine.backgroundColor = Beering.Gray01
        nikNameTextField.textColor = Beering.Gray01
        
        IDTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        IDTextField.addTarget(self, action: #selector(checkValidID), for: .editingChanged)
        IDTextField.addTarget(self, action: #selector(validJoinMembership), for: .editingChanged)
        // 중복체크로 변경해야 함
        passwordTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        passwordTextField.addTarget(self, action: #selector(checkValidPassword), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validJoinMembership), for: .editingChanged)
        
        confirmPassword.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        
        nikNameTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        nikNameTextField.addTarget(self, action: #selector(checkValidNikName), for: .editingChanged)
        nikNameTextField.addTarget(self, action: #selector(validJoinMembership), for: .editingChanged)
        // 중복체크로 변경해야 함
        confirmPassword.addTarget(self, action: #selector(confirmSamePassword), for: .editingChanged)
        confirmPassword.addTarget(self, action: #selector(validJoinMembership), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(confirmSamePassword), for: .editingChanged)
        differentPasswordText.isHidden = true
        
    }
    func IDcheckDupliBtnInit(){
        IDcheckDupliBtn.setTitle("중복체크", for: .normal)
        IDcheckDupliBtn.layer.cornerRadius = 10
        IDcheckDupliBtn.backgroundColor = Beering.Gray03
    }
    func nikDupliCheckBtnInit(){
        nikDupliCheckBtn.setTitle("중복체크", for: .normal)
        nikDupliCheckBtn.layer.cornerRadius = 10
        nikDupliCheckBtn.backgroundColor = Beering.Gray03
    }
    func joinMembershipBtnInit(){
        joinMembershipBtn.setTitle("회원가입", for: .normal)
        joinMembershipBtn.layer.cornerRadius = 10
        joinMembershipBtn.backgroundColor = Beering.Gray03
    }
    func termsOfUseInit(){
        termsOfUse1.changeTitle(termsOfUseTitle: "비어링 서비스 이용약관")
        termsOfUse2.changeTitle(termsOfUseTitle: "개인정보 수집 및 이용동의")
        termsOfUse3.changeTitle(termsOfUseTitle: "마케팅 활용/광고성 정보 수신동의")
        termsOfUse3.changeOption(optionImage: UIImage(named: "SelectOption")!)
        termsOfUse1.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        termsOfUse2.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        termsOfUse3.displayDetailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        
        termsOfUse1.checkBox.addTarget(self, action: #selector(validJoinMembership), for: .touchUpInside)
        termsOfUse2.checkBox.addTarget(self, action: #selector(validJoinMembership), for: .touchUpInside)
        
    }
    
    func checkNikNameRegEx(inputNikName: String, inputRegEx: String) -> Bool{
        var nikNameRegExCondition: Bool = false
        if inputNikName.isEmpty{
            return false
        }
        
        if let regEx = try? NSRegularExpression(pattern: inputRegEx, options: .caseInsensitive){
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
    
    func checkIDRegEx(inputID: String, inputRegEx: String) -> Bool{
        var nikNameRegExCondition: Bool = false
        let template: String = "Beer"
        if inputID.isEmpty{
            return false
        }
        
        if let regEx = try? NSRegularExpression(pattern: inputRegEx, options: .caseInsensitive){
            let results = regEx.stringByReplacingMatches(in: inputID, range: NSRange(location: 0, length: inputID.count), withTemplate: template)
            if results.count == template.count{
                nikNameRegExCondition = true
            }
            else{
                nikNameRegExCondition = false
            }
        }
        return nikNameRegExCondition
    }
    
    @IBAction func changeVisibleMode(_ sender: Any){
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
            passwordInvisibleMode.setImage(UIImage(named: "VisibleButton"), for: .normal)
        }
        else{
            passwordTextField.isSecureTextEntry = true
            passwordInvisibleMode.setImage(UIImage(named: "InvisibleButton"), for: .normal)
        }
    }
    @IBAction func changeConfirmVisibleMode(_ sender: Any){
        if confirmPassword.isSecureTextEntry{
            confirmPassword.isSecureTextEntry = false
            confirmInvisibleMode.setImage(UIImage(named: "VisibleButton"), for: .normal)
        }
        else{
            confirmPassword.isSecureTextEntry = true
            confirmInvisibleMode.setImage(UIImage(named: "InvisibleButton"), for: .normal)
        }
    }
    
    @objc func checkValidNikName(){
        let nikName: String = self.nikNameTextField.text ?? ""
        nikNameTextField.textColor = Beering.Black
        nikNameCharLimit.isHidden = false
        nikNameRegEx.text = "영문/한글/숫자✓"
        
        if self.nikNameTextField.text!.count > 0{
            self.nikNameTextFieldUnderLine.backgroundColor = Beering.Black
        }
        else{
            self.nikNameTextFieldUnderLine.backgroundColor = Beering.Gray01
        }
        let nikRegEx = "[A-Za-z가-힣0-9]"
        var isRegEx: Bool = false
        var charLimit: Bool = false
        
        if checkNikNameRegEx(inputNikName: nikName, inputRegEx: nikRegEx){
            isRegEx = true
            self.nikNameRegEx.textColor = Beering.Black
        }
        else{
            isRegEx = false
            self.nikNameRegEx.textColor = Beering.Gray01
        }
        
        if nikName.count >= 1 && nikName.count <= 10{
            charLimit = true
            self.nikNameCharLimit.textColor = Beering.Black
        }
        else {
            charLimit = false
            self.nikNameCharLimit.textColor = Beering.Gray01
        }
        
        if isRegEx && charLimit{
            self.nikDupliCheckBtn.backgroundColor = Beering.Black
            validNikName = true
        }
        else{
            self.nikDupliCheckBtn.backgroundColor = Beering.Gray03
            validNikName = false
        }
    }
    func checkPasswordRegEx(inputPassword: String, inputRegEx: String) -> Int{

        var regExNum: Int = 0
        if let regEx = try? NSRegularExpression(pattern: inputRegEx, options: .caseInsensitive){
            regExNum = regEx.numberOfMatches(in: inputPassword, range: NSRange(location: 0, length: inputPassword.count))
            
        }
        
        return regExNum
    }
    
    @objc func checkValidPassword(){
        passwordTextField.isSecureTextEntry = true
        let password: String = passwordTextField.text ?? ""
        passwordTextField.textColor = Beering.Black
        let engRegEx: String = "[a-zA-Z]"
        let specialRegEx: String = "[!@#$%]"
        let numRegEx: String = "[0-9]"
        
        let engNum : Int = checkPasswordRegEx(inputPassword: password, inputRegEx: engRegEx)
        let specialNum : Int = checkPasswordRegEx(inputPassword: password, inputRegEx: specialRegEx)
        let numeral : Int = checkPasswordRegEx(inputPassword: password, inputRegEx: numRegEx)
        
        var isEngRegEx: Bool = false
        var isSpecailRegEx: Bool = false
        var isNumRegEx: Bool = false
        var charLimit: Bool = false
        
        if password.count > 0{
            passwordTextFieldUnderLine.backgroundColor = Beering.Black
        }
        else{
            passwordTextFieldUnderLine.backgroundColor = Beering.Gray01
        }
        //print("eng: \(engNum)")
        if engNum > 0{
            isEngRegEx = true
            passwordEngRegEx.textColor = Beering.Black
        }
        else{
            isEngRegEx = false
            passwordEngRegEx.textColor = Beering.Gray01
        }
        //print("special: \(specialNum)")
        if specialNum > 0 && (password.count == engNum + specialNum + numeral){
            isSpecailRegEx = true
            passwordSpecialRegEx.textColor = Beering.Black
        }
        else{
            isSpecailRegEx = false
            passwordSpecialRegEx.textColor = Beering.Gray01
        }
        //print("num: \(numeral)")
        if numeral > 0 {
            isNumRegEx = true
            passwordNumRegEx.textColor = Beering.Black
        }
        else{
            isNumRegEx = false
            passwordNumRegEx.textColor = Beering.Gray01
        }
        
        if password.count >= 8 && password.count <= 20{
            charLimit = true
            passwordCharLimit.textColor = Beering.Black
        }
        else{
            charLimit = false
            passwordCharLimit.textColor = Beering.Gray01
        }
        if password.count != engNum + specialNum + numeral{
            validPassword = false
            passwordTextFieldUnderLine.backgroundColor = Beering.Red
        }
        else{
            if isEngRegEx && isNumRegEx && isSpecailRegEx && charLimit{
                validPassword = true
                passwordTextFieldUnderLine.backgroundColor = Beering.Green
            }
            else{
                validPassword = false
                passwordTextFieldUnderLine.backgroundColor = Beering.Red
            }
        }
        
    }
    
    @objc func checkValidID(){
        
        let ID: String = IDTextField.text ?? ""
        duplicateIDText.isHidden = true
        IDTextField.textColor = Beering.Black
        
        if ID.count > 0{
            self.IDTextFieldUnderLine.backgroundColor = Beering.Black
        }
        else{
            self.IDTextFieldUnderLine.backgroundColor = Beering.Gray01
        }
        
        let emailRegEx: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        if checkIDRegEx(inputID: ID, inputRegEx: emailRegEx) && ID.count > 4{
            validID = true
            IDcheckDupliBtn.backgroundColor = Beering.Black
        }
        else{
            validID = false
            IDcheckDupliBtn.backgroundColor = Beering.Gray03
        }
    }
    
    @objc func displayDetail(){
        let termsOfUseStoryboard = UIStoryboard(name: "TermsOfUse", bundle: nil)
        let termsOfUseVC = termsOfUseStoryboard.instantiateViewController(withIdentifier: "TermsOfUse")
        termsOfUseVC.modalPresentationStyle = .automatic
        termsOfUseVC.view.backgroundColor = UIColor(red: 16, green: 15, blue: 15, alpha: 0.3)
        self.present(termsOfUseVC, animated: true)
    }
    
    @objc func confirmSamePassword(){
        passwordTextField.isSecureTextEntry = true
        confirmPassword.textColor = Beering.Black
        if passwordTextField.text == confirmPassword.text{
            samePassword = true
            confirmPasswordUnderLine.backgroundColor = Beering.Green
            differentPasswordText.isHidden = true
        }
        else{
            confirmPasswordUnderLine.backgroundColor = Beering.Red
            samePassword = false
            differentPasswordText.isHidden = false
        }
    }
    
    @objc func validJoinMembership(){
        if validPassword && validID && validNikName && termsOfUse1.isChecked && termsOfUse2.isChecked{
            if samePassword{
                joinMembershipBtn.backgroundColor = Beering.Black
                validJoin = true
            }
            else{
                joinMembershipBtn.backgroundColor = Beering.Gray03
                validJoin = false
            }
        }
        else{
            joinMembershipBtn.backgroundColor = Beering.Gray03
            validJoin = false
        }
    }
    @IBAction func IDDuplicateBtnTap(_ sender: Any){
        if validID{
            duplicateIDText.isHidden = false
            
            let url = "https://api.beering.shop/members/validate/username"
            let parameters = ["username": IDTextField.text!] as Dictionary
            
            struct ResultsError: Decodable {
                let fieldName: String
                let rejectValue: String
                let message: String
            }

            struct DuplicateID: Decodable {
                let isSuccess: String
                let responseCode: Int
                let responseMessage: String
                let result: ResultsError
            }

            
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<1001)
                .responseJSON { response in
                    
                /** 서버로부터 받은 데이터 활용 */
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        // -> JSON x
                        let decoder = JSONDecoder()
                        let duplicateID = try decoder.decode(DuplicateID.self, from: jsonData)
                        //self.isDuplicateID = duplicateID.isSuccess
                        print("#############")
                        print(duplicateID)
                    }
                catch {
                    print("JSON Decoding Error: \(error)")
                }
                case .failure(let error):
                    print(error)
                    print("####json error failure case")
                }
            }
            if isDuplicateID{
                IDTextFieldUnderLine.backgroundColor = Beering.Green
                duplicateIDText.textColor = Beering.Green
                duplicateIDText.text = "사용할 수 있는 아이디예요"
            }
            else{
                IDTextFieldUnderLine.backgroundColor = Beering.Red
                duplicateIDText.textColor = Beering.Red
                duplicateIDText.text = "이미 사용하고 있는 아이디예요"
            }
            
        }
    }
    @IBAction func nikDuplicateBtnTap(_ seder: Any){
        
        
        if validNikName{
            nikNameCharLimit.isHidden = true
            
            let url = "https://beering-72501f868a10.herokuapp.com/members/validate/nickname" // Replace with your API endpoint URL
            let parameters: Parameters = [
                "nikname": nikNameTextField.text!
            ]
            struct duplicateNikname : Decodable{
                let isSuccess: Bool
                let responseCode: Int
                let responseMessage: String

                enum CodingKeys: String, CodingKey {
                    case isSuccess = "isSuccess"
                    case responseCode = "responseCode"
                    case responseMessage = "responseMessage"
                }
            }
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
                /** 서버로부터 받은 데이터 활용 */
                switch response.result {
                case .success(let data): do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    let duplicateNikname = try decoder.decode(duplicateNikname.self, from: jsonData)
                    self.isDuplicateNik = duplicateNikname.isSuccess
                    print("#############")
                    print(duplicateNikname)
                    }
                catch {
                    print("JSON Decoding Error: \(error)")
                }
                case .failure(let error): print(error)
                    print("###json is not faild")
                }
            }

            if isDuplicateNik{
                nikNameTextFieldUnderLine.backgroundColor = Beering.Green
                
                nikNameRegEx.textColor = Beering.Green
                nikNameRegEx.text = "사용할 수 있는 닉네임이에요"
            }
            else{
                nikNameTextFieldUnderLine.backgroundColor = Beering.Red
                
                nikNameRegEx.textColor = Beering.Red
                nikNameRegEx.text = "이미 사용하고 있는 닉네임이에요"
            }
        }
    }
    
    
    @IBAction func normalJoinMembershipBtnTap(_ sender: Any) {
        let url = "https://api.beering.shop/auth/signup"
        
        let agreements: [[String: Any]] = [
            ["name": "SERVICE", "isAgreed": true],
            ["name": "PERSONAL", "isAgreed": true],
            ["name": "MARKETING", "isAgreed": false]
        ]

        let signupRequest: [String: Any] = [
            "username": IDTextField.text!,
            "password": passwordTextField.text!,
            "nickname": nikNameTextField.text!,
            "agreements": agreements
        ]
        
        print("*********")
        print(signupRequest)
        
//        let normalSignUp = SignUpRequest(username: IDTextField.text!, password: passwordTextField.text!, nickname: nikNameTextField.text!, agreements: ("SERVICE":true, "PERSONAL":true, "MARKETING":false))
        struct results : Codable{
            let errors: String
            let message: String
            let objectName: String
        }
        struct SignUpResponse: Codable {
            let isSuccess: Bool
            let responseCode: Int
            let responseMessage: String
//            let result: results?
        }
//        let parameters: Parameters = [
//                "username": normalSignUp.username,
//                "password": normalSignUp.password,
//                "nickname": normalSignUp.nickname,
//                "agreements": normalSignUp.agreements
//            ]
        AF.request(url,
                   method: .post,
                   parameters: signupRequest,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .responseJSON {  response in

            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    let signUpResponse = try decoder.decode(SignUpResponse.self, from: jsonData)
                    //accessLogin = loginResponse.isSuccess
                    print("#############")
                    print(signUpResponse)
                    }
                catch {
                    print("JSON Decoding Error: \(error)")
                    print("error success in fail case ")
                }

            case .failure(let error):
                print("Alamofire Request Error: \(error)")
                print("error failure case ")
            }
                
        }
    }
}

enum Beering{
    static let Black: UIColor = UIColor(red: 16, green: 15, blue: 15) // Beering Black
    static let Gray03: UIColor = UIColor(red: 226, green: 226, blue: 226) // Beering Gray/03
    static let Gray01: UIColor = UIColor(red: 167, green: 167, blue: 167) // Beering Gray/01
    static let Red: UIColor = UIColor(red: 255, green: 56, blue: 56)// Beering Red
    static let Green: UIColor = UIColor(red: 0, green: 176, blue: 81)// Beering Green
}

struct NormalJoinSBPreView:PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "NormalJoin", bundle: nil).instantiateInitialViewController()!.toPreview()
    }
}

