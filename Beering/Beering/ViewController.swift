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

}

struct VCPreView:PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}

