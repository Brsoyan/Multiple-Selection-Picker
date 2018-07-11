//
//  UIView+Shake.swift
//  Picker
//
//  Created by Hayk Brsoyan on 6/29/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

extension UIView {
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func shake(duration: Double, repeatCount: Float, shakeSize: CGFloat) {
        let keyPath = "position"
        let shake = CABasicAnimation(keyPath: keyPath)
        shake.duration = duration
        shake.repeatCount = repeatCount
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: center.x - shakeSize, y: center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: center.x + shakeSize, y: center.y))
        
        layer.add(shake, forKey: keyPath)
    }
}
