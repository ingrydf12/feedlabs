//  PrimaryButton.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 06/08/24.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 330, height: 50)
            .background (Color.darkAqua) // Change color to "Primary Color" or Action
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(.white)
    }
}
