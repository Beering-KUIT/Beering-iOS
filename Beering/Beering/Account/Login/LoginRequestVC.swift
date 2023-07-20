//
//  LoginRequestVC.swift
//  Beering
//

import UIKit
import SwiftUI

class LoginRequestVC: UIViewController {

    @IBOutlet weak var loginMain: UILabel!
    @IBOutlet weak var loginRequestButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextInit()
        loginRequestButtonInit()                       // loginRequestButton initiallize
        loginSkipButtonInit()                          // loginSkipButton initiallize
    }
    @IBAction func loginRequestBtnTap(_ seder: Any){
        print(1)
       // let LoginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        print(2)
        //let LoginVC = LoginStoryboard.instantiateViewController(withIdentifier: "Login")as! LoginVC
        //let LoginVC = LoginStoryboard.instantiateInitialViewController()
        print(3)
        //print(self.navigationController as Any)
        //self.navigationController?.pushViewController(LoginVC, animated: true)
        print(4)
        //print("test")
        
    }
    
    @IBAction func loginSkipBtnTap(_ sender: Any){
        
        let TabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let TabBarVC = TabBarStoryboard.instantiateInitialViewController()
        // 메인 화면을 풀 스크린으로 표시
        TabBarVC?.modalPresentationStyle = .fullScreen
        self.present(TabBarVC!, animated: true)
    }
    
    func mainTextInit(){
        loginMain.text = "로그인하고\n나만의\n주류기록 남기기" // text initiallize
        //loginMain.font.pointSize = 48
        loginMain.textColor = UIColor(rgb: 0x100f0f)
    }
    func loginRequestButtonInit(){
        loginRequestButton.setTitle("로그인할게요", for: .normal)
        loginRequestButton.layer.cornerRadius = 0
        loginRequestButton.layer.backgroundColor = UIColor(rgb: 0x100F0F).cgColor
        //shadow options
        loginRequestButton.layer.shadowOpacity = 0
        loginRequestButton.layer.shadowColor = nil
        //let shadowSize: CGSize = 20.0
        //loginRequestButton.layer.shadowOffset = .shadowSize
        
    }
    func loginSkipButtonInit(){
        skipButton.setTitle("먼저 둘러볼게요", for: .normal)
        skipButton.setUnderLine()
    }


}
extension UIButton {
    func setUnderLine(){
        guard let title = title(for: .normal) else {return}
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
    
}
struct VCPreView:PreviewProvider {
    static var previews: some View {
        LoginRequestVC().toPreview()
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
