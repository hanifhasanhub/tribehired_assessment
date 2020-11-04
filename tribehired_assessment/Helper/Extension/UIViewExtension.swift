//
//  UIViewExtension.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 04/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    //:- Set image view circle with border
    func makeCircle(border: CGFloat, color: UIColor) {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
        self.layer.borderWidth = border
        self.layer.borderColor = color.cgColor
    }
    
    func borderRadiusView(border: CGFloat, radius : CGFloat, color: UIColor) {
        self.layer.borderWidth = border
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func dropShadow(conerRadius : CGFloat,shadowRadius : CGFloat, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = conerRadius
        layer.shadowOffset = CGSize(width: 0, height: 2)
     }
    
    func roundSpecific(corners: CACornerMask, cornerRadius: CGFloat, color: UIColor, border: CGFloat) {
        self.layer.borderWidth = border
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corners
     }
     
}
