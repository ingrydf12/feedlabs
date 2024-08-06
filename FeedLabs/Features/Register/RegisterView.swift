//
//  RegisterView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct RegisterView: View {
    
    let coordinator: AuthCoordinator

    var body: some View {
        Button("Voltar", action: {
            coordinator.navigateTo(screen: .login)
        })
        
        Text("Register")
    }
}
struct RegisterViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        EntryView(coordinator: coordinator)
    }
}
#Preview {
    RegisterViewContainer()
}
