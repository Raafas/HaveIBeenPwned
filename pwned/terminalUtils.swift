//
//  terminalUtils.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

final class TerminalUtils {
    
    enum color: String {
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case white = "\u{001B}[0;37m"
    }
    
    enum style: String {
        case none = "\u{001B}[0m"
        case bold = "\u{001B}[1m"
        case dim = "\u{001B}[2m"
        case underline = "\u{001B}[4m"
        case blink = "\u{001B}[5m"
        case inverted = "\u{001B}[7m"
        case hidden = "\u{001B}[8m"
    }
    
    enum background: String {
        case black = "\u{001B}[40m"
        case red = "\u{001B}[41m"
        case green = "\u{001B}[42m"
        case yellow = "\u{001B}[43m"
        case blue = "\u{001B}[44m"
        case magenta = "\u{001B}[45m"
        case cyan = "\u{001B}[46m"
        case white = "\u{001B}[47m"
    }
    
    
    func AnsiString(value: String, color: TerminalUtils.color, style: TerminalUtils.style = TerminalUtils.style.none) -> String {
        return "\(style.rawValue)\(color.rawValue)\(value)\(TerminalUtils.color.white.rawValue)\(TerminalUtils.style.none.rawValue)"
    }
}
