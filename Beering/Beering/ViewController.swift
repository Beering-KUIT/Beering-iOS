//
//  ViewController.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/03.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var loginMain: UILabel!
    @IBOutlet weak var LoginRequestButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextInit()
        loginRequestButtonInit()
        loginSkipButtonInit()
        

//        self.view.backgroundColor = .yellow
    }
    
    override func viewDidAppear(_ animated: Bool) {


    }
    
    func mainTextInit(){
        loginMain.text = "로그인하고\n나만의\n주류기록 남기기"
        loginMain.textColor = BeeringColor.Black
    }
    
    func loginRequestButtonInit(){
        LoginRequestButton.setTitle("로그인할게요", for: .normal)
        LoginRequestButton.layer.cornerRadius = 0
        LoginRequestButton.layer.backgroundColor = BeeringColor.Black.cgColor
        LoginRequestButton.layer.shadowOpacity = 0
        LoginRequestButton.layer.shadowColor = nil
    }
    
    func loginSkipButtonInit(){
        skipButton.setTitle("먼저 둘러볼게요", for: .normal)
        skipButton.setUnderLine()
    }
    
    @IBAction func loginRequestBtnTap(_ sender: Any) {
        
        let LoginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let LoginVC = LoginStoryboard.instantiateViewController(withIdentifier: "Login")
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(LoginVC, animated: true)

    }
    
    
    @IBAction func loginDoneBtnTap(_ sender: Any) {
        
        let TabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let TabBarVC = TabBarStoryboard.instantiateInitialViewController()
        // 메인 화면을 풀 스크린으로 표시
        TabBarVC?.modalPresentationStyle = .fullScreen
        self.present(TabBarVC!, animated: true)
        
        // 윈도우의 rootViewController로 설정하여 메인 화면 표시
//        UIApplication.shared.windows.first?.rootViewController = HomeVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }
    
}

extension UIButton{
    func setUnderLine(){
        guard let title = title(for: .normal) else {return}
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
//struct VCPreView:PreviewProvider {
//    static var previews: some View {
//        ViewController().toPreview()
//    }
//}

