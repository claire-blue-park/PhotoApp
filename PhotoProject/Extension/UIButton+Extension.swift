//
//  UIButton+Extension.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    static func sortStyle(_ sort: Sorts) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "list.bullet.indent")
        configuration.title = sort.toString
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .neutral8
        return configuration
    }
    
    static func colorStyle(color: Colors) -> UIButton.Configuration {
        let tintColor = switch color {
        case .mono: UIColor.systemGray
        case .black: UIColor.black
        case .white: UIColor.white
        case .yellow: UIColor.systemYellow
        case .orange: UIColor.systemOrange
        case .red: UIColor.systemRed
        case .purple: UIColor.purple
        case .magenta: UIColor.magenta
        case .green: UIColor.green
        case .teal: UIColor.systemTeal
        case .blue: UIColor.systemBlue
        }
        
        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(systemName: "circle.fill")
        configuration.image?.withTintColor(tintColor)
        configuration.title = color.toString
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .neutral8
        return configuration
    }
}
