//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var userManager = UserManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(userManager.user?.id ?? "nil")")
            Text("NAME: \(userManager.user?.name ?? "nil")")
            
            Text("Eventos de hoje")
                .font(.tahoma(.subtitle))
            
            
            Button {
                AuthManager.shared.signOut()
            } label: {
                Text("Sair")
            }
            if let user = userManager.user {
                InviteList(user: user.id ?? "")
            }

        }
        .padding()
    }
}

#Preview {
    HomeView()
}
