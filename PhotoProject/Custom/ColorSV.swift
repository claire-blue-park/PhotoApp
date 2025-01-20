//
//  ColorSV.swift
//  PhotoProject
//
//  Created by Claire on 1/20/25.
//

import UIKit

class ColorSV: BaseSV {
    let currentColorButton: ColorToggleButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        let monoTB = ColorToggleButton()
        monoTB.color = .mono
        
        let blackTB  = ColorToggleButton()
        blackTB.color = .black
        
        let whiteTB  = ColorToggleButton()
        whiteTB.color = .white
        
        let yellowTB  = ColorToggleButton()
        yellowTB.color = .yellow
        
        let orangeTB  = ColorToggleButton()
        orangeTB.color = .orange
        
        let redTB  = ColorToggleButton()
        redTB.color = .red
        
        let purpleTB  = ColorToggleButton()
        purpleTB.color = .purple
        
        let magentaTB  = ColorToggleButton()
        magentaTB.color = .magenta
        
        let greenTB  = ColorToggleButton()
        greenTB.color = .green
        
        let tealTB  = ColorToggleButton()
        tealTB.color = .teal
        
        let blueTB  = ColorToggleButton()
        blueTB.color = .blue
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        
        [monoTB, blackTB, whiteTB, yellowTB, orangeTB, redTB, purpleTB, magentaTB, greenTB, tealTB, blueTB].forEach { colorTB in
            stack.addArrangedSubview(colorTB)
        }
        addSubview(stack)
    }
}
