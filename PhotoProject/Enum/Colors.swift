//
//  Colors.swift
//  PhotoProject
//
//  Created by Claire on 1/20/25.
//

import UIKit

enum Colors {
    case mono
    case black
    case white
    case yellow
    case orange
    case red
    case purple
    case magenta
    case green
    case teal
    case blue
    
    var toString: String {
        switch self {
        case .mono: String(localized: "ColorMono")
        case .black: String(localized: "ColorBlack")
        case .white: String(localized: "ColorWhite")
        case .yellow: String(localized: "ColorYellow")
        case .orange: String(localized: "ColorOrange")
        case .red: String(localized: "ColorRed")
        case .purple: String(localized: "ColorPurple")
        case .magenta: String(localized: "ColorMagenta")
        case .green: String(localized: "ColorGreen")
        case .teal: String(localized: "ColorTeal")
        case .blue: String(localized: "ColorBlue")
        }
    }
    
    var colorQuery: String {
        switch self {
        case .mono: "black_and_white"
        case .black: "black"
        case .white: "white"
        case .yellow: "yellow"
        case .orange: "orange"
        case .red: "red"
        case .purple: "purple"
        case .magenta: "magenta"
        case .green: "green"
        case .teal: "teal"
        case .blue: "blue"
        }
    }
}
