//
//  Routes.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct Routes: View {
    
    let coordinator: HomeCoordinator

    var body: some View {
        TabView {
            coordinator.navigateToTeams()
                .tabItem {
                    Label("Teams", systemImage: "1.circle")
                }

            coordinator.navigateToHome()
                .tabItem {
                    Label("Home", systemImage: "2.circle")
                }

            coordinator.navigateToChats()
                .tabItem {
                    Label("Chats", systemImage: "3.circle")
                }
        }
    }
}
struct RoutesPreviewContainer: View {
    @StateObject var coordinator = HomeCoordinator()

    var body: some View {
        Routes(coordinator: coordinator)
    }
}

#Preview {
    RoutesPreviewContainer()
}
