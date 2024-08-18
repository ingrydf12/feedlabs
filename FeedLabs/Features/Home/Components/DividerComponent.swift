//
//  DividerComponent.swift
//  FeedLabs
//
//  Created by User on 09/08/24.
//

import SwiftUI

struct DividerComponent: View {
    let color: Color
    let text: String?

    init(color: Color = .inactive, text: String? = nil) {
        self.color = color
        self.text = text
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            DividerRectangle(color: color)
            
            if let text = text, !text.isEmpty {
                Text(text)
                    .padding(.horizontal, 12)
                    .font(.tahoma(.secondaryButton))
                    .multilineTextAlignment(.center)
                
                DividerRectangle(color: color)
            }
            
        }
        
    }
}

private struct DividerRectangle: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 4)
            .foregroundStyle(color)
    }
}

#Preview {
    VStack(spacing: 20) {
        DividerComponent(color: .blue, text: "9:00")
        DividerComponent(color: .green)
    }
}
