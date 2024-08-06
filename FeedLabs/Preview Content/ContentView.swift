//
//  ContentView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authManager = AuthManager.shared

    var body: some View {
        if authManager.isAuthenticated {
            AuthRoutes()
        } else {
            HomeRoutes()
        }
    }
}

#Preview {
    ContentView()
}
