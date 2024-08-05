//
//  ContentView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var coordinator = AuthCoordinator()

    var body: some View {
        
        switch coordinator.currentScreen {
        case .entry:
            coordinator.entryView
        case .login:
            coordinator.loginView
        case .register:
            coordinator.registerView
        case .passwordRecovery:
            Text("Password Recovery")
        case .home:
            coordinator.homeView
        }
    }
}

#Preview {
    ContentView()
}
