//
//  StarSlider.swift
//  Beering
//
//  Created by YoonSub Lim on 2023/07/27.
//

import UIKit

class StarSlider: UISlider {
    
    // Slider Touch 시 해당 값으로 리턴
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let fPercent = tapPoint.x/width
        let nNewValue = self.maximumValue * Float(fPercent)
        if nNewValue != self.value {
            self.value = nNewValue
        }
        return true
    }

}
