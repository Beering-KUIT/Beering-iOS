//
//  ReviewDetailVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/08/01.
//

import UIKit

class ReviewDetailVC: UIViewController {

    @IBOutlet weak var reviewDetailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewDetailText.textViewInit()

    }
    


}
