//
//  Routes.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeRoutes: View {

    var body: some View {
        TabView {
            TeamsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Label("Teams", systemImage: "1.circle")
                }

            HomeView()
                .tabItem {
                    Image(systemName: "calendar")
                    Label("Home", systemImage: "2.circle")
                }

            ListUsers()
                .tabItem {
                    Image(systemName: "ellipsis.bubble")
                    Label("Chats", systemImage: "3.circle")
                    
                }
        }.tint(.mint)
    }
}

#Preview {
    HomeRoutes()
}
