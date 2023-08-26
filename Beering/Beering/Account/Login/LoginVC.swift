//
//  LoginVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/20.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var findMembershipBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    @IBOutlet weak var IDTextField:UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invisibleModeButton: UIButton!
    @IBOutlet weak var IDUnderLine: UIView!
    @IBOutlet weak var passwordUnderLine: UIView!
    
    var validID: Bool = false
    var validPassword: Bool = false
    var validLogin: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinBtnInit()
        findMembershipBtnInit()
        loginBtnInit()
        textfieldInit()
    }
    
    @IBAction func normalLoginBtnTap(_ sendor: Any){
        var accessLogin: Bool = false
        let url = "https://api.beering.shop/auth/login"
        let params = ["username": IDTextField.text! , "password": passwordTextField.text!] as Dictionary
        
        print(params)
        //let JwtInfo = ["accessToken": String, "refreshToken": String] as Dictionary
        struct jwtInfo: Codable{
            var accessToken: String
            var refreshToken: String
        }
        struct results : Codable{
            let memberId : Int
            let jwtInfo : [String: String]
        }
        struct LoginResponse: Codable {
            let isSuccess: Bool
            let responseCode: Int
            let responseMessage: String
            let result: results
        }
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .responseJSON { [self] response in

            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: jsonData)
                    accessLogin = loginResponse.isSuccess
                    print("#######Response######")
                    print("\(loginResponse.isSuccess)")
                    print("#######Token######")
                    print("\(loginResponse.result.jwtInfo)")
                    if validLogin && accessLogin {
                        let TabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
                        let TabBarVC = TabBarStoryboard.instantiateInitialViewController()
                        TabBarVC?.modalPresentationStyle = .fullScreen
                        self.present(TabBarVC!, animated: true)
                    }
                    }
                catch {
                    print("JSON Decoding Error: \(error)")
                }

            case .failure(let error):
                print("Alamofire Request Error: \(error)")
            }
                
        }
        print(validLogin)
        print(accessLogin)
    }
    @IBAction func kakaoLoginBtnTap(_ sendor: Any){
        //
    }
    @IBAction func normalJoin(_ sendor: Any){
        let NormalJoinStoryboard = UIStoryboard(name: "NormalJoin", bundle: nil)
        let NormalJoinVC = NormalJoinStoryboard.instantiateViewController(identifier: "NormalJoin")
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(NormalJoinVC, animated: true)
    }
    @IBAction func kakaoJoin(_ sendor: Any){
        let KAKAOJoinStoryboard = UIStoryboard(name: "KAKAOJoin", bundle: nil)
        let KAKAOJoinVC = KAKAOJoinStoryboard.instantiateViewController(identifier: "KAKAOJoin")
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(KAKAOJoinVC, animated: true)
    }
    
    @IBAction func changeVisibleMode(){
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
            invisibleModeButton.setImage(UIImage(named: "VisibleButton"), for: .normal)
        }
        else{
            passwordTextField.isSecureTextEntry = true
            invisibleModeButton.setImage(UIImage(named: "InvisibleButton"), for: .normal)
            
        }
    }
    
    func textfieldInit(){
        IDTextField.text = "아이디를 입력해주세요"
        IDTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        IDTextField.addTarget(self, action: #selector(IDAttribute), for: .editingChanged)
        IDTextField.addTarget(self, action: #selector(isValidLogin), for: .editingChanged)
        IDTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = false
        invisibleModeButton.setTitle("", for: .normal)
    
        passwordTextField.addTarget(self, action: #selector(isSequrityTextEntry), for: .editingChanged)
        passwordTextField.text = "비밀번호를 입력해주세요"
        passwordTextField.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        passwordTextField.addTarget(self, action: #selector(passwordAttribute), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValidLogin), for: .editingChanged)
    }
    func joinBtnInit(){
        joinBtn.setTitle("회원가입", for: .normal)
        //joinBtn.setUnderLine()
    }
    func findMembershipBtnInit(){
        findMembershipBtn.setTitle("비밀번호 찾기", for: .normal)
        //findMembershipBtn.setUnderLine()
    }
    func loginBtnInit(){
        loginBtn.setTitle("LOGIN", for: .normal)
        //loginBtn.layer.cornerRadius = 6
        loginBtn.layer.shadowColor = BeeringColor.Gray03.cgColor
        //loginBtn.layer.shadowOpacity = 1.0
        //loginBtn.layer.shadowOffset = CGSize.zero
        kakaoLoginBtn.setTitle("", for: .normal)
    }
    
    @objc private func isSequrityTextEntry(){
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func IDAttribute(){
        IDTextField.textColor = BeeringColor.Black
        if IDTextField.text!.isEmpty{
            validID = false
            IDUnderLine.backgroundColor = BeeringColor.Gray01
        }
        else{
            validID = true
            IDUnderLine.backgroundColor = BeeringColor.Black
        }
    }
    @objc func passwordAttribute(){
        passwordTextField.textColor = BeeringColor.Black
        if passwordTextField.text!.isEmpty{
            validPassword = false
            passwordUnderLine.backgroundColor = BeeringColor.Gray01
        }
        else{
            validPassword = true
            passwordUnderLine.backgroundColor = BeeringColor.Black
        }
    }
    
    @objc func isValidLogin(){
        if validID && validPassword{
            validLogin = true
            loginBtn.backgroundColor = BeeringColor.Black
        }
        else{
            validLogin = false
            loginBtn.backgroundColor = BeeringColor.Gray03
        }
    }
}
extension UITextField {
    
    func setClearButton(with image: UIImage, mode: UITextField.ViewMode) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal) //custom 취소버튼으로 설정
        clearButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingChanged)
        self.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.changeColorText), for: .editingDidBegin)
        //self.addTarget(self, action: #selector(UITextField.isSequrityTextEntry), for: .editingChanged)
        self.rightView = clearButton
        self.rightViewMode = mode
    }
    @objc private func changeColorText(){
        guard let string = self.placeholder else {
                    return
                }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: UIColor.black])
    }
    
    @objc private func displayClearButtonIfNeeded() {
        self.rightView?.isHidden = (self.text?.isEmpty) ?? true
        if self.text!.count > 0 {
            self.setClearButton(with: UIImage(named: "CancelBlack.png")!, mode: .always)
        }
        else{
            self.setClearButton(with: UIImage(named: "CancelGray.png")!, mode: .always)
        }
    }
    
    @objc private func clear(sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
 
    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }
    
    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}

enum BeeringColor{
    static let Black: UIColor = UIColor(red: 16, green: 15, blue: 15) // Beering Black
    static let Gray03: UIColor = UIColor(red: 226, green: 226, blue: 226) // Beering Gray/03
    static let Gray01: UIColor = UIColor(red: 167, green: 167, blue: 167) // Beering Gray/01
    static let Red: UIColor = UIColor(red: 255, green: 56, blue: 56)// Beering Red
    static let Green: UIColor = UIColor(red: 0, green: 176, blue: 81)// Beering Green
}
