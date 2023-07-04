//
//  ViewController.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/03.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .yellow
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let LoginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let LoginVC = LoginStoryboard.instantiateInitialViewController()
        // 메인 화면을 풀 스크린으로 표시
        LoginVC?.modalPresentationStyle = .fullScreen
        self.present(LoginVC!, animated: true)
        
        // 윈도우의 rootViewController로 설정하여 메인 화면 표시
        UIApplication.shared.windows.first?.rootViewController = LoginVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }

}

struct VCPreView:PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}

