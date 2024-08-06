//
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
            .background {
                Color.cyan
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 12)
                    .stroke()
                    .foregroundStyle(.white)
            })
    }
}
