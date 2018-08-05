//
//  terminalUtils.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

extension String {
    public enum Color: String {
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case white = "\u{001B}[0;37m"
    }
    
    public enum Style: String {
        case none = "\u{001B}[0m"
        case bold = "\u{001B}[1m"
        case dim = "\u{001B}[2m"
        case underline = "\u{001B}[4m"
        case blink = "\u{001B}[5m"
        case inverted = "\u{001B}[7m"
        case hidden = "\u{001B}[8m"
    }
    
    func AnsiString(color: Color = .white, style: Style = .none) -> String {
        return "\(style.rawValue)\(color.rawValue)\(self)\(Color.white.rawValue)\(Style.none.rawValue)"
    }
}
