//
//  Button.swift
//  OTPUI
//
//  Created by Róbert Koltai on 2020. 09. 30..
//  Copyright © 2020. Supercharge. All rights reserved.
//

public struct Button {
    public var title: String
    public var icon: UIImage?

    public init(title: String, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
    }
}
