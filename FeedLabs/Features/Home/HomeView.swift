//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(viewModel.userManager.user?.id ?? "nil")")
            Text("NAME: \(viewModel.userManager.user?.name ?? "nil")")
            
            Text("Eventos de hoje")
                .font(.tahoma(.subtitle))
            
            
            Button {
                AuthManager.shared.signOut()
            } label: {
                Text("Sair")
            }

        }
        .padding()
    }
}

#Preview {
    HomeView()
}
