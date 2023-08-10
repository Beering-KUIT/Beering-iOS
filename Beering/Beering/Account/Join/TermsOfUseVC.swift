//
//  TermsOfUseVC.swift
//  Beering
//
//  Created by byeoungjik on 2023/07/25.
//

import UIKit

class TermsOfUseVC: UIViewController {

    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var agreementTitle: UILabel!
    @IBOutlet weak var termsOfUseBackBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtnInit()
        displayTitle()
        displayMainText()
        // Do any additional setup after loading the view.
    }
    func backBtnInit(){
        termsOfUseBackBtn.setTitle("", for: .normal)
    }
    func displayTitle(){
        agreementTitle.text = "제목"
    }
    func displayMainText(){
        mainText.text = "본문 Lorem ipsum dolor sit amet consectetur. Turpis senectus purus viverra pulvinar. Magna quisque odio ipsum fermentum sit id. Tincidunt tortor euismod sed vulputate interdum purus mattis risus auctor. Cras maecenas pellentesque dolor ornare netus ullamcorper duis."
    }
    @IBAction func backBtnTap(_ sender: Any) {
//        let KAKAOStoryboard = UIStoryboard(name: "KAKAOJoin", bundle: nil)
//        let KAKAOJoinVC = KAKAOStoryboard.instantiateViewController(withIdentifier: "KAKAOJoin")
//        KAKAOJoinVC.dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: true)
    }
    
}

