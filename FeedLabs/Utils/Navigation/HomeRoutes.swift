//
//  Routes.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI
struct HomeRoutes: View {
    
    @State var inviteManager = InviteManager.shared
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab){
            NavigationStack{
                TeamsView()
            }
            .tag(0)
            .tabItem {
                    Image(systemName: "person.3")
                    Label("Teams", systemImage: "1.circle")
                }
            NavigationStack{
                HomeView()
            }
            .tag(1)
            .tabItem {
                Image(systemName: "calendar")
                Label("Home", systemImage: "2.circle")
            }
            
            NavigationStack{
                ChatList()
            }.tag(2)
                .tabItem {
                Image(systemName: "ellipsis.bubble")
                Label("Chats", systemImage: "3.circle")
                
            }.badge(inviteManager.pendingInvitesCount > 0 ? "\(inviteManager.pendingInvitesCount)" : nil)
        }
        .tint(.accent)
    }
}

#Preview {
    HomeRoutes()
}
