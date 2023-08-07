//
//  FilterVC.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/13.
//

import UIKit
import SwiftUI

protocol SendFilterDataDelegate: AnyObject{
    func receiveData(data: String)
    func clearFilterOptionData()
}

class FilterVC: UIViewController {
    
    weak var delegate: SendFilterDataDelegate?
    
    var filterOption = selectedFilterOption()
    
    @IBOutlet var sortOptions: [UIButton]!
    @IBOutlet var liquorTypes: [UIButton]!
    
    @IBOutlet var filterOptionTitleViews: [UIView]!
    
    @IBOutlet weak var minimumPriceTextField: UITextField! {
        didSet { minimumPriceTextField?.addDoneButtonOnKeyboard() }
    }
    @IBOutlet weak var maximumPriceTextField: UITextField! {
        didSet { maximumPriceTextField?.addDoneButtonOnKeyboard() }
    }
    
    @IBOutlet var filterApplyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for view in filterOptionTitleViews{
            view.titleViewInit()
        }
        
        for sortByBtn in sortOptions{
            sortByBtn.addTarget(self, action: #selector(sortByBtnTap), for: .touchUpInside)
            sortByBtn.addTarget(self, action: #selector(updateFilterApplyBtn), for: .touchUpInside)
            sortByBtn.makeCircular()
        }
        
        for liquorBtn in liquorTypes{
            liquorBtn.addTarget(self, action: #selector(liquorTypeBtnTap), for: .touchUpInside)
            liquorBtn.addTarget(self, action: #selector(updateFilterApplyBtn), for: .touchUpInside)
        }
        
        minimumPriceTextField.delegate = self
        minimumPriceTextField.addTarget(self, action: #selector(updateFilterApplyBtn), for: .valueChanged)
        
        maximumPriceTextField.delegate = self
        maximumPriceTextField.addTarget(self, action: #selector(updateFilterApplyBtn), for: .valueChanged)
        
    }
    
    @objc func sortByBtnTap(_ sender: UIButton) {
        
        if sender.titleLabel?.text != filterOption.sortBy {
            filterOption.sortBy = (sender.titleLabel?.text)!
            
            for sortBtn in sortOptions{
                sortBtn.isSelected = false
                sortBtn.backgroundColor = UIColor(named: "Gray03")
            }
            sender.isSelected = true
            sender.backgroundColor = UIColor(named: "Beering_Black")
        }else{
            filterOption.sortBy = ""
            
            for sortBtn in sortOptions{
                sortBtn.isSelected = false
                sortBtn.backgroundColor = UIColor(named: "Gray03")
            }
        }
        
    }
    
    /// TODO index 방식 Refactoring
    @objc func liquorTypeBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        switch sender{
        case liquorTypes[0]:
            if sender.isSelected{
                sender.setImage(UIImage(named: "beer_filled"), for: .normal)
                filterOption.liquorType.append("beer")
            }else{
                sender.setImage(UIImage(named: "beer_blank"), for: .normal)
                filterOption.liquorType.removeAll{ $0 == "beer" }
            }
        case liquorTypes[1]:
            if sender.isSelected{
                sender.setImage(UIImage(named: "wine_filled"), for: .normal)
                filterOption.liquorType.append("wine")
            }else{
                sender.setImage(UIImage(named: "wine_blank"), for: .normal)
                filterOption.liquorType.removeAll{ $0 == "wine" }
            }
        case liquorTypes[2]:
            if sender.isSelected{
                sender.setImage(UIImage(named: "traditional_liquor_filled"), for: .normal)
                filterOption.liquorType.append("traditional_liquor")
            }else{
                sender.setImage(UIImage(named: "traditional_liquor_blank"), for: .normal)
                filterOption.liquorType.removeAll{ $0 == "traditional_liquor" }
            }
        default:
            print("default")
        }
    }
    
    @objc func updateFilterApplyBtn() {
        
        print(filterOption)
        
        if filterOption.sortBy != "" || !filterOption.liquorType.isEmpty || filterOption.maxPrice != "" || filterOption.minPrice != "" {
            
            filterApplyBtn.isEnabled = true
            filterApplyBtn.backgroundColor = UIColor(named: "Beering_Black")
        }else{
            filterApplyBtn.isEnabled = false
            filterApplyBtn.backgroundColor = UIColor(named: "Gray01")
        }
    }
    
    @IBAction func filterApplyBtnTap(_ sender: Any) {
        
        delegate?.clearFilterOptionData()
        
        if filterOption.sortBy != ""{
            delegate?.receiveData(data: filterOption.sortBy)
        }
        if !filterOption.liquorType.isEmpty{
            for typeEng in filterOption.liquorType{
                var typeKor: String?
                
                switch typeEng{
                case "beer":
                    typeKor = "맥주"
                case "wine":
                    typeKor = "와인"
                case "traditional_liquor":
                    typeKor = "전통주"
                default: break
                }
                
                delegate?.receiveData(data: typeKor!)
            }
        }
        if filterOption.minPrice != "" && filterOption.maxPrice != ""{
            delegate?.receiveData(data: filterOption.minPrice + "원 ~ " + filterOption.maxPrice + "원")
        }else if filterOption.minPrice != ""{
            delegate?.receiveData(data: filterOption.minPrice + "원 이상")
        }else if filterOption.maxPrice != ""{
            delegate?.receiveData(data: filterOption.maxPrice + "원 이하")
        }
        
        /// TODO API 호출하여, 검색 결과 주류들 반영하기
        
        dismiss(animated: true)
    }
    
}

extension FilterVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 현재 입력된 문자열과 새로운 문자열을 합친 최종 문자열
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        // 최종 문자열에서 숫자 부분만 추출 (콤마도 제거)
        let filteredString = updatedString.filter { "0123456789".contains($0) }
        
        if filteredString != "" && Int(filteredString) != 0{
            // 숫자 포맷팅
            // 콤마를 추가하여 새로운 텍스트 설정
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = ","
            formatter.groupingSize = 3
            
            if let number = Int(filteredString), let formattedText = formatter.string(from: NSNumber(value: number)) {
                textField.text = formattedText
            }
        }else{
            textField.text = ""
        }
        
        if textField == minimumPriceTextField{
            filterOption.minPrice = textField.text ?? ""
        }else if textField == maximumPriceTextField{
            filterOption.maxPrice = textField.text ?? ""
        }
        
        updateFilterApplyBtn()
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //MARK: - minimum <= maximum ? Validation
        // minimum 입력시, minimum > maximum 이라면 maximum 을 99999+
        if textField == minimumPriceTextField{
            if var minimumPriceText = minimumPriceTextField.text, var maximumPriceText = maximumPriceTextField.text{
                
                minimumPriceText = minimumPriceText.filter { "0123456789".contains($0) }
                maximumPriceText = maximumPriceText.filter { "0123456789".contains($0) }
                
                if let minimumPrice = Int(minimumPriceText), let maximumPrice = Int(maximumPriceText) {
                    if minimumPrice > maximumPrice {
                        maximumPriceTextField.text = ""
                    }
                }
            }
        }
        // maximum 입력시, minimum > maximum 이라면 minimum 을 0
        else if textField == maximumPriceTextField{
            if var minimumPriceText = minimumPriceTextField.text, var maximumPriceText = textField.text {
                
                minimumPriceText = minimumPriceText.filter { "0123456789".contains($0) }
                maximumPriceText = maximumPriceText.filter { "0123456789".contains($0) }
                
                if let minimumPrice = Int(minimumPriceText), let maximumPrice = Int(maximumPriceText) {
                    if maximumPrice < minimumPrice {
                        minimumPriceTextField.text = ""
                    }
                }
            }
        }
        
    }
}

struct FilterSBPreView:PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController()!.toPreview()
    }
}

struct selectedFilterOption{
    var sortBy: String = ""
    var liquorType: [String] = []
    var minPrice: String = ""
    var maxPrice: String = ""
}
