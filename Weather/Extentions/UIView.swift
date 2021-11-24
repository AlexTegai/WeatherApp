//
//  UIView.swift
//  Weather
//
//  Created by Alex Tegai on 19.10.2021.
//

import UIKit

extension UIView {
    func gradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
    func getConditionColor(with conditionString: String) {

        switch conditionString {
        case "few clouds":
            gradient(colors: [.systemPurple, .systemPink, .systemBlue])
        case "overcast clouds":
            gradient(colors: [.systemPurple, .systemOrange, .systemPink])
        case "mostly cloudy":
            gradient(colors: [.systemPink, .systemPurple, .systemOrange])
        case "broken clouds":
            gradient(colors: [.systemYellow, .systemPink, .systemOrange])
        case "dust":
            gradient(colors: [.systemOrange, .brown, .systemGray])
        case "light rain":
            gradient(colors: [.systemRed, .systemTeal, .systemPink])
        case "moderate rain":
            gradient(colors: [.systemBlue, .systemPink, .systemGray])
        case "clear sky":
            gradient(colors: [.systemTeal, .systemBlue, .systemPurple])

        default:
            gradient(colors: [.systemGray, .systemOrange, .systemRed])
        }
    }
}
