//
//  CALayer+Animations.swift
//  ShadowOTP
//
//  Created by David Horvath on 2017. 06. 26..
//  Copyright © 2017. Supercharge. All rights reserved.
//

// MARK: - Shadows
public extension CALayer {
    func drawBottomShadow() {
        self.shadowColor = Constants.darkShadowColor.cgColor
        shadowOffset = CGSize(width: 0, height: shadowOffsetValue)
        shadowRadius = shadowRadiusValue
        shadowOpacity = shadowOpacityValue
        listenToTraitChange()
    }

    func drawTopShadow() {
        self.shadowColor = Constants.lightShadowColor.cgColor
        shadowOffset = CGSize(width: 0, height: -shadowOffsetValue)
        shadowRadius = shadowRadiusValue
        shadowOpacity = shadowOpacityValue
        listenToTraitChange()
    }

    func drawNearMarkerShadow() {
        let rect: CGRect = CGRect(x: self.frame.midX - 22.5, y: self.frame.maxY - 45.0, width: 45.0, height: 45.0)
        shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 22.5).cgPath
        shadowColor = Constants.darkShadowColor.cgColor
        shadowRadius = 3
        shadowOpacity = 0.15
        listenToTraitChange()
    }

    func drawFarMarkerShadow() {
        let rect: CGRect = CGRect(x: self.frame.midX - 12.5, y: self.frame.maxY - 25.0, width: 25.0, height: 25.0)
        shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 12.5).cgPath
        shadowColor = Constants.darkShadowColor.cgColor
        shadowRadius = 3.5
        shadowOpacity = 0.2
        listenToTraitChange()
    }

    func drawPopupShadow(center: CGPoint) {
        let rect: CGRect = CGRect(x: center.x - Constants.popupShadowWidth / 2,
                                  y: center.y,
                                  width: Constants.popupShadowWidth,
                                  height: Constants.popupShadowHeight)
        shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: Constants.popupShadowCornerRadius).cgPath
        shadowColor = Constants.darkShadowColor.cgColor
        shadowRadius = Constants.popupShadowRadius
        shadowOpacity = Constants.popupShadowOpacity
        listenToTraitChange()
    }
}

// MARK: - Private
private extension CALayer {
    func listenToTraitChange() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(traitChanged),
                                               name: .traitCollectionDidChange,
                                               object: nil)
    }

    @objc func traitChanged() {
        let color: UIColor
        if shadowOffset.height < 0 {
            color = Constants.lightShadowColor
            shadowOffset = CGSize(width: 0, height: -shadowOffsetValue)
        } else {
            color = Constants.darkShadowColor
            shadowOffset = CGSize(width: 0, height: shadowOffsetValue)
        }
        shadowColor = color.cgColor
        shadowRadius = shadowRadiusValue
        shadowOpacity = shadowOpacityValue
    }

    var shadowOpacityValue: Float {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return Constants.tooltipDarkShadowOpacity
            }
        }

        return Constants.tooltipShadowOpacity
    }

    var shadowRadiusValue: CGFloat {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return Constants.tooltipDarkShadowRadius
            }
        }

        return Constants.tooltipShadowRadius
    }

    var shadowOffsetValue: Int {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return Constants.tooltipDarkShadowHeight
            }
        }

        return Constants.tooltipShadowHeight
    }
}

// MARK: - Constants
private extension CALayer {
    enum Constants {
        static let popupShadowWidth: CGFloat = 45.0
        static let popupShadowHeight: CGFloat = 45.0
        static let popupShadowCornerRadius: CGFloat = 45.0
        static let popupShadowRadius: CGFloat = 3.0
        static let popupShadowOpacity: Float = 0.15
        static let tooltipShadowRadius: CGFloat = 15.0
        static let tooltipDarkShadowRadius: CGFloat = 8.0
        static let tooltipShadowOpacity: Float = 0.8
        static let tooltipDarkShadowOpacity: Float = 0.8
        static let tooltipShadowHeight = 16
        static let tooltipDarkShadowHeight = 4
        static let lightShadowColor = ColorName.Background.bg5.color
        static let darkShadowColor = ColorName.Background.bg1.color
    }
}
