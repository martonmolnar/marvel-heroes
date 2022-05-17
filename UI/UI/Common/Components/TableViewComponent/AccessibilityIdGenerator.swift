//
//  AccessibilityIdGenerator.swift
//  OTPBank
//
//  Created by David Horvath on 2018. 10. 09..
//  Copyright © 2018. Supercharge Ltd. All rights reserved.
//

public final class AccessibilityIdGenerator {
    public enum AccessibilityIdSuffix {
        static let button = "_button_id"
        static let label = "_label_id"
        static let textField = "_inputfield_id"
        static let textView = "_textview_id"
        static let otpSwitch = "_switch_id"
        static let image = "_image_id"
        static let barButton = "_barbutton_id"
        static let cell = "_cell_id"
        static let header = "_header_id"
        static let footer = "_footer_id"
        static let progress = "_progress_id"
        static let picker = "_picker_id"
        static let pageControl = "_page_control"
    }

    public static func idForButton(with text: String) -> String? {
        return text + AccessibilityIdSuffix.button
    }

    public static func idForLabel(with text: String) -> String? {
        return text + AccessibilityIdSuffix.label
    }

    public static func idForTextField(with text: String) -> String? {
        return text + AccessibilityIdSuffix.textField
    }

    public static func idForTextView(with text: String) -> String? {
        return text + AccessibilityIdSuffix.textView
    }

    public static func idForPicker(with text: String) -> String? {
        return text + AccessibilityIdSuffix.picker
    }

    public static func idForSwitch(with text: String) -> String? {
        return text + AccessibilityIdSuffix.otpSwitch
    }

    public static func idForImage(with text: String) -> String? {
        return text + AccessibilityIdSuffix.image
    }

    public static func idForBarButton(with text: String) -> String? {
        return text + AccessibilityIdSuffix.barButton
    }

    public static func idForProgress(with text: String) -> String? {
        return text + AccessibilityIdSuffix.progress
    }

    public static func idForCell(with text: String, at indexPath: IndexPath) -> String? {
        return "\(indexPath.section)_\(indexPath.row)_\(text)" + AccessibilityIdSuffix.cell
    }

    public static func idForHeader(with text: String, at indexPath: IndexPath) -> String? {
        return "\(indexPath.section)_\(text)" + AccessibilityIdSuffix.header
    }

    public static func idForCell(with text: String, at index: Int) -> String? {
        return "\(index)_\(text)" + AccessibilityIdSuffix.cell
    }

    public static func idForHeader(with text: String, at section: Int) -> String? {
        return "\(section)_\(text)" + AccessibilityIdSuffix.header
    }

    public static func idForFooter(with text: String, at section: Int) -> String? {
        return "\(section)_\(text)" + AccessibilityIdSuffix.footer
    }

    public static func idForPageControl(with text: String) -> String? {
        return text + AccessibilityIdSuffix.pageControl
    }
}

extension String {
    func hasButtonSuffix() -> Bool {
        return self.hasSuffix(AccessibilityIdGenerator.AccessibilityIdSuffix.button)
    }

    func hasLabelSuffix() -> Bool {
        return self.hasSuffix(AccessibilityIdGenerator.AccessibilityIdSuffix.label)
    }

    func hasImageSuffix() -> Bool {
        return self.hasSuffix(AccessibilityIdGenerator.AccessibilityIdSuffix.image)
    }

    func hasSwitchSuffix() -> Bool {
        return self.hasSuffix(AccessibilityIdGenerator.AccessibilityIdSuffix.otpSwitch)
    }
}
