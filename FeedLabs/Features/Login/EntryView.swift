//
//  EntryView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct EntryView: View {
    let coordinator: AuthCoordinator

    var body: some View {
        VStack {
            Button("Go to Login") {
                coordinator.navigateTo(screen: .login)
            }
        }
    }
}

struct EntryViewContainer: View {
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        EntryView(coordinator: coordinator)
    }
}

#Preview {
    EntryViewContainer()
}
