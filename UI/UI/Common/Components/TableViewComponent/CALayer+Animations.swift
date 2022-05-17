//
//  CALayer+Animations.swift
//  ShadowOTP
//
//  Created by David Horvath on 2017. 06. 26..
//  Copyright © 2017. Supercharge. All rights reserved.
//

import AudioToolbox.AudioServices

public let kDefaultTextAnimationDuration: CFTimeInterval = 0.5
public let kDefaultButtonAnimationDuration: CFTimeInterval = 0.3
public let kDefaultComponentAnimationDuration: CFTimeInterval = 1.0
public let kMoveAnimationDistance: Double = 10
public let kTransform: String = "transform"
public let kCAAnimationTransform: String = "Transform"
public let kTransformScale: String = "transform.scale"
public let kCAAnimationScale: String = "Scale"
public let kPosition: String = "position"
public let kCAAnimationPosition: String = "Position"
public let kOpacity: String = "opacity"
public let kCAAnimationOpacity: String = "Opacity"
public let kBackgroundColor: String = "backgroundColor"
public let kCAAnimationBackgroundColor: String = "BackgroundColor"
public let kPath = "path"
public let kCAAnimationPath = "Path"
public let kCAAnimationKeyframe = "Keyframe"
public let kRotation = "Rotation"

// MARK: - Animations
public extension CALayer {
    func showRotationAnimation() {
        add(rotationAnimation(), forKey: kRotation)
    }

    func showButtonAnimation(duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        let currentScale = 0.85
        add(scaleAnimation(from: currentScale, to: 1, duration: duration), forKey: kCAAnimationScale)
        add(opacityAnimation(from: 0, to: 1, duration: duration / 2), forKey: kCAAnimationOpacity)
    }

    func hideButtonAnimation(duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        let currentScale = 1.0

        add(scaleAnimation(from: currentScale, to: 0.85, duration: duration), forKey: kCAAnimationScale)
        add(opacityAnimation(from: 1, to: 0, duration: duration / 2), forKey: kCAAnimationOpacity)
    }

    func pressButtonAnimation(duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        let currentScale = 1.0
        add(scaleAnimation(from: currentScale, to: 0.85, duration: duration), forKey: kCAAnimationScale)
    }

    func releaseButtonAnimation(duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        let currentScale = 0.85
        add(scaleAnimation(from: currentScale, to: 1, duration: duration), forKey: kCAAnimationScale)
    }

    func showTextAnimation(duration: CFTimeInterval = kDefaultTextAnimationDuration) {
        add(opacityAnimation(from: 0, to: 1, duration: duration), forKey: kCAAnimationOpacity)
        add(moveDownAnimation(duration: duration), forKey: kCAAnimationPosition)
    }

    func showTitleAnimation(duration: CFTimeInterval = kDefaultTextAnimationDuration) {
        add(opacityAnimation(from: 0, to: 1, duration: duration), forKey: kCAAnimationOpacity)
        add(moveRighAnimation(duration: duration), forKey: kCAAnimationPosition)

    }

    func showComponentAnimation(duration: CFTimeInterval = kDefaultComponentAnimationDuration) {
        add(opacityAnimation(from: 0, to: 1, duration: duration), forKey: kCAAnimationOpacity)
    }

    func pulsateAnimation(offset: CFTimeInterval, duration: CFTimeInterval = kDefaultTextAnimationDuration) {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [
            scaleAnimation(from: 0.9, to: 1.3, duration: duration),
            opacityAnimation(from: 0.6, to: 1.0, duration: duration)
        ]
        animationGroup.duration = duration
        animationGroup.autoreverses = true
        animationGroup.repeatCount = .greatestFiniteMagnitude
        animationGroup.beginTime = offset

        add(animationGroup, forKey: nil)
    }

    func sonarAnimation(fromColor: CGColor,
                        toColor: CGColor,
                        strokeColor: CGColor,
                        reverse: Bool,
                        duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        let fromPath = reverse ? bigCirclePath() : smallCirclePath()
        let toPath = reverse ? smallCirclePath() : bigCirclePath()
        let circleShape = createCircleShape(path: fromPath, color: strokeColor)

        let animation = CAAnimationGroup()
        animation.animations = [
            pathAnimation(from: fromPath, to: toPath, duration: duration),
            colorAnimation(from: fromColor, to: toColor, duration: duration),
            opacityAnimation(from: reverse ? 0 : 1, to: reverse ? 1 : 0, duration: duration)
        ]
        animation.duration = duration
        circleShape.add(animation, forKey: nil)
        addSublayer(circleShape)
    }

    func shakeAnimation(vibration: Bool, duration: CFTimeInterval = kDefaultButtonAnimationDuration) {
        if vibration {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }

        let animation = keyframeAnimation(values: [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5.0, 0.0, 0.0)),
            NSValue(caTransform3D: CATransform3DMakeTranslation(5.0, 0.0, 0.0))],
                                          duration: duration)
        add(animation, forKey: kCAAnimationKeyframe)
    }
}

// MARK: - Private
private extension CALayer {
    // MARK: - Animations
    func rotationAnimation() -> CABasicAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = -Double.pi * 2
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude

        return rotation
    }

    func moveDownAnimation(duration: CFTimeInterval) -> CABasicAnimation {
        let from: CGPoint = CGPoint(x: position.x, y: position.y - CGFloat(kMoveAnimationDistance))
        return moveAnimation(from: from, to: position)
    }

    func moveRighAnimation(duration: CFTimeInterval) -> CABasicAnimation {
        let from: CGPoint = CGPoint(x: position.x - CGFloat(kMoveAnimationDistance), y: position.y)
        return moveAnimation(from: from, to: position)
    }

    func moveAnimation(from: CGPoint,
                       to: CGPoint,
                       duration: CFTimeInterval = kDefaultTextAnimationDuration) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: kPosition)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = NSValue(cgPoint: from)
        animation.toValue = NSValue(cgPoint: to)

        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        return animation
    }

    func opacityAnimation(from: Double, to: Double, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: kOpacity)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = NSNumber(value: from)
        animation.toValue = NSNumber(value: to)
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        return animation
    }

    func scaleAnimation(from: Double, to: Double, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: kTransformScale)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = NSNumber(value: from)
        animation.toValue = NSNumber(value: to)
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        return animation
    }

    func colorAnimation(from: CGColor, to: CGColor, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: kBackgroundColor)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.isRemovedOnCompletion = false

        return animation
    }

    func pathAnimation(from: CGPath, to: CGPath, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: kPath)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.isRemovedOnCompletion = false

        return animation
    }

    func keyframeAnimation(values: [NSValue], duration: CFTimeInterval) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: kTransform)
        animation.values = values
        animation.duration = duration
        animation.repeatCount = 2
        animation.speed = 2.0
        animation.autoreverses = true

        return animation
    }

    // MARK: - Helper methods
    func createCircleShape(path: CGPath, color: CGColor) -> CAShapeLayer {
        let circleShape = CAShapeLayer()
        circleShape.path = path
        circleShape.fillColor = ColorName.Static.clear.color.cgColor
        circleShape.strokeColor = color
        circleShape.opacity = 0.0
        circleShape.lineWidth = 4

        return circleShape
    }

    func smallCirclePath() -> CGPath {
        let width = frame.width
        let rect = CGRect(x: width / 2, y: width / 2, width: 0.1, height: 0.1)
        return CGPath(ellipseIn: rect, transform: nil)
    }

    func bigCirclePath() -> CGPath {
        let width = frame.width
        let newWidth = width * 3.5
        let halfDiff = (newWidth - width) / 2
        let rect = CGRect(x: -halfDiff, y: -halfDiff, width: newWidth, height: newWidth)
        return CGPath(ellipseIn: rect, transform: nil)
    }
}
