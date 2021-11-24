//
//  UILabel.swift
//  Weather
//
//  Created by Alex Tegai on 18.10.2021.
//

import UIKit

extension UILabel {
    func addSetupLabel(text: String, font: Fonts, size: CGFloat) {
        self.text = text
        self.textColor = .white
        self.font = UIFont(name: chooseFont(font: font), size: size)
    }
}

enum Fonts {
    case swiftBold
    case swiftLight
}

func chooseFont(font: Fonts) -> String {
    switch font {
    case .swiftBold:
        return "Swift-Bold"
    case .swiftLight:
        return "Swift-Light"
    }
}
