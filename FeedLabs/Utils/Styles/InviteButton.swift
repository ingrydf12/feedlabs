//
//  InviteButton.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 13/08/24.
//

import SwiftUI

struct InviteButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 50)
            .foregroundStyle(.darkAqua)
            .background(
            Circle()
                .foregroundStyle(.darkAqua.opacity(0.2))
            )
            .padding(15)
    }
}
