//
//  UIViewExtensions.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.05.21.
//

import UIKit

extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}

extension UIView {
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, lineWidht: CGFloat, color: CGColor) -> CAShapeLayer {
        let borderLayer = CAShapeLayer()

        borderLayer.lineWidth = lineWidht
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
}
