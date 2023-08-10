//
//  CheckDuplicateVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/27.
//

import UIKit

class CheckDuplicateVC: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!

    @IBOutlet weak var background: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundDismiss()
    }
    
    func popUpViewInit(){
        popUpView.layer.cornerRadius = 10
    }
    
    func backgroundDismiss(){
        background.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                        action:Selector(("checkBtnTap:"))))
    }

    @IBAction func checkBtnTap(_ sender: Any) {
        self.dismiss(animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
