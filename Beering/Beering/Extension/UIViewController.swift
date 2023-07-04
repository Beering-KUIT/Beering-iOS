//
//  UIViewController.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/04.
//

import Foundation
import SwiftUI

// 230704 SwiftUI Preview 기능 위해 추가
#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
