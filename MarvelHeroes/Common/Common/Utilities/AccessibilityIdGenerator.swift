//
//  AccessibilityIdGenerator.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 19..
//

public final class AccessibilityIdGenerator {
    public enum AccessibilityIdSuffix {
        static let label = "_label_id"
        static let textField = "_inputfield_id"
        static let image = "_image_id"
        static let cell = "_cell_id"
    }

    public static func idForLabel(with text: String) -> String? {
        return text + AccessibilityIdSuffix.label
    }

    public static func idForTextField(with text: String) -> String? {
        return text + AccessibilityIdSuffix.textField
    }

    public static func idForImage(with text: String) -> String? {
        return text + AccessibilityIdSuffix.image
    }

    public static func idForCell(with text: String, at indexPath: IndexPath) -> String? {
        return "\(indexPath.section)_\(indexPath.row)_\(text)" + AccessibilityIdSuffix.cell
    }

    public static func idForCell(with text: String, at index: Int) -> String? {
        return "\(index)_\(text)" + AccessibilityIdSuffix.cell
    }
}
