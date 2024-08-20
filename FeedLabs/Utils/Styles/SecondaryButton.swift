//
//  SecondaryButton.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 08/08/24.
//

import SwiftUI

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 330, height: 50)
            .background (.accent.opacity(0.15)) // Change color to "Primary Color" or Action
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(.accent)
    }
}

