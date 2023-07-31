//
//  UITextView.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/08/01.
//

import Foundation
import UIKit

extension UITextView{
    
    func textViewInit(){
        
        // 먼저 행간 조절 스타일 설정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let attributedString = NSMutableAttributedString(string: self.text)
        
        // 자간 조절 설정
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1), range: NSRange(location: 0, length: attributedString.length))
        
        // 행간 스타일 추가
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        
        // TextView에 세팅
        self.attributedText = attributedString
        
        // Text contentInset
        self.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
}
