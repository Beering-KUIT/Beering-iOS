//
//  FilterVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/13.
//

import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet var sortOptions: [UIButton]!
    @IBOutlet var filterOptionTitleViews: [UIView]!
    
    @IBOutlet weak var minimumPriceTextField: UITextField!
    @IBOutlet weak var maximumPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for view in filterOptionTitleViews{
            view.titleViewInit()
        }
        
        for buttonView in sortOptions{
            buttonView.makeCircular()
        }
        
        minimumPriceTextField.delegate = self
        maximumPriceTextField.delegate = self
    }
    

}

extension FilterVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 현재 입력된 문자열과 새로운 문자열을 합친 최종 문자열
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        // 최종 문자열에서 숫자 부분만 추출
        let filteredString = updatedString.filter { "0123456789".contains($0) }
        
        if Int(filteredString) == 0{
            return false
        }
            
        // 숫자 포맷팅
        // 콤마를 추가하여 새로운 텍스트 설정
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3

        if let number = Int(filteredString), let formattedText = formatter.string(from: NSNumber(value: number)) {
            textField.text = formattedText
        }

        return false
    }
}
