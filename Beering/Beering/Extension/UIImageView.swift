//
//  UIImageView.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/05.
//

import Foundation
import UIKit

extension UIImageView{
    

    // url to Image. e.g. 프로필 이미지 등
    func loadImage(from urlString: String) {
        // URL 생성
        guard let url = URL(string: urlString) else {
            return
        }
        
        // URLSession을 사용하여 비동기적으로 이미지 로드
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("## 이미지 로딩 에러: \(error)")
                return
            }
            
            // 데이터를 UIImage로 변환 후 메인 스레드에서 이미지 뷰에 설정
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
