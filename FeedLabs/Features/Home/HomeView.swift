//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack{
            Text("Home")
            Button(action: {
                AuthManager.shared.signOut()
            }, label: {
                Text("Sair")
            })
        }
    }
}

#Preview {
    HomeView()
}
