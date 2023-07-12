//
//  SearchVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/12.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var filterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading    the view.
        
        layoutInit()
        
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

extension SearchVC{
    
    func layoutInit(){
        searchTextField.borderStyle = .none
        searchView.addBottomBorderWithColor(color: UIColor.black, width: 1)
        filterView.makeCircular()
    }
}
