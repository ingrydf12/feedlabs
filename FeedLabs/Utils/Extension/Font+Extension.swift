//
//  Font+Extension.swift
//  FeedLabs
//
//  Created by User on 07/08/24.
//

import SwiftUI

extension Font { 
    enum Tahoma {
        case bold(CGFloat)
        case regular(CGFloat)
        
        var fontName: String {
            switch self {
            case .bold:
                return "Tahoma-Bold"
            case .regular:
                return "Tahoma-Regular"
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .bold(let size), .regular(let size):
                return size
            }
        }
    }
    
    enum FontType {
        case title
        case subtitle
        case body
        case secondary
        case minor
        case primaryButton
        case secondaryButton
        
        var font: Tahoma {
            switch self {
            case .title:
                return .bold(24)
            case .subtitle:
                return .regular(20)
            case .body:
                return .regular(16)
            case .secondary:
                return .regular(14)
            case .minor:
                return .regular(12)
            case .primaryButton:
                return .bold(18)
            case .secondaryButton:
                return .regular(18)
            }
        }
    }
    
    static func tahoma(_ type: FontType) -> Font {
        let font = type.font
        return Font.custom(font.fontName, size: font.fontSize)
    }
}
