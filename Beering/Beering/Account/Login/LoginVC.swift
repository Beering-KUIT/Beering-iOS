//
//  LoginVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/20.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var findMembershipRequestBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var IDTextField:UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinBtnInit()
        findMembershipBtnInit()
        loginBtnInit()
        textfieldInit()
    }
    
    @IBAction func nomalLoginBtnTap(_ sendor: Any){
        let TabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let TabBarVC = TabBarStoryboard.instantiateInitialViewController()
        // 메인 화면을 풀 스크린으로 표시
        TabBarVC?.modalPresentationStyle = .fullScreen
        self.present(TabBarVC!, animated: true)
    }
    @IBAction func kakaoLoginBtnTap(_ sendor: Any){
        //
    }
    
    func textfieldInit(){
        IDTextField.text = "아이디를 입력해주세요"
        passwordTextField.text = "비밀번호를 입력해주세요"
        IDTextField.setClearButton(with: UIImage(named: "CancelButton2.png")!, mode: .always)
        passwordTextField.setClearButton(with: UIImage(named: "CancelButton2.png")!, mode: .always)
        //IDTextField.clearButtonMode = .always
        //passwordTextField.clearButtonMode = .always
        IDTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
    }
    func joinBtnInit(){
        joinBtn.setTitle("회원가입", for: .normal)
        joinBtn.setUnderLine()
    }
    func findMembershipBtnInit(){
        findMembershipRequestBtn.setTitle("비밀번호 찾기", for: .normal)
        findMembershipRequestBtn.setUnderLine()
    }
    func loginBtnInit(){
        loginBtn.setTitle("LOGIN", for: .normal)
        //loginBtn.layer.cornerRadius = 6
        loginBtn.layer.shadowColor = UIColor.gray.cgColor
        //loginBtn.layer.shadowOpacity = 1.0
        //loginBtn.layer.shadowOffset = CGSize.zero
    }

}
extension UITextField {
    
    func setClearButton(with image: UIImage, mode: UITextField.ViewMode) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal) //custom 취소버튼으로 설정
        clearButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(changeColorClearBtn), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.displayClearButtonIfNeeded), for: .editingChanged)
        self.addTarget(self, action: #selector(UITextField.clear(sender:)), for: .editingDidBegin)
        self.rightView = clearButton
        self.rightViewMode = mode
    }
    @objc //textfield 취소버튼 Black으로 색 변경
    private func changeColorClearBtn(clearBotton: UIButton){
        clearBotton.setImage(UIImage(named:"CancelButton1.png"), for: .normal)
    }
    
    @objc //textfield 취소버튼 보여주기?
    private func displayClearButtonIfNeeded() {
        self.rightView?.isHidden = (self.text?.isEmpty) ?? true
    }
    
    @objc //textfield 내용 삭제
    private func clear(sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

