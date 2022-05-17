//
//  CAShapeLayer+Animation.swift
//  OTPProto
//
//  Created by David Horvath on 2017. 06. 28..
//  Copyright © 2017. Supercharge. All rights reserved.
//

private let kStrokeEnd: String = "strokeEnd"
private let kCircleAnimationKey: String = "animateCircle"

public extension CAShapeLayer {

    enum DrawingType {
        case top
        case bottom
    }

    func showExpenseAnimation(duration: CFTimeInterval = 0.7) {
        let animation = CABasicAnimation(keyPath: kStrokeEnd)
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeEnd = 1.0

        add(animation, forKey: kCircleAnimationKey)
    }
}
