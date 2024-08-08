//
//  Font+Extension.swift
//  FeedLabs
//
//  Created by User on 07/08/24.
//

import SwiftUI

extension Font {
    
    enum Tahoma {
        case bold
        case regular
        
        var fontName: String {
            switch self {
            case .bold:
                return "Tahoma-Bold"
            case .regular:
                return "Tahoma-Regular"
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
        
        var fontDetails: (Tahoma, CGFloat) {
            switch self {
            case .title:
                return (.bold, 24)
            case .subtitle:
                return (.regular, 20)
            case .body:
                return (.regular, 16)
            case .secondary:
                return (.regular, 14)
            case .minor:
                return (.regular, 12)
            case .primaryButton:
                return (.bold, 18)
            case .secondaryButton:
                return (.regular, 18)
            }
        }
    }
    
    static func tahoma(_ type: FontType) -> Font {
        let (fontStyle, fontSize) = type.fontDetails
        return Font.custom(fontStyle.fontName, size: fontSize)
    }
    
    static func tahoma(_ type: Tahoma, size: CGFloat) -> Font {
        return Font.custom(type.fontName, size: size)
    }
}

