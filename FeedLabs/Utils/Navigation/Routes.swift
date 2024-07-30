//
//  Routes.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI

struct Routes: View {
    
    @State private var selectedIndex: Int = 0
    @StateObject var authManager = AuthManager.shared
    
    var body: some View {
        if !authManager.isAuthenticated {
            TabView(selection: $selectedIndex) {
                NavigationStack() {
                    LoginView()
                        .navigationTitle("Login")
                }
                .tabItem {
                    Image(systemName: "1.circle")
                }
                .tag(0)
                
                NavigationStack() {
                    RegisterView()
                        .navigationTitle("Register")
                }
                .tabItem {
                    Image(systemName: "2.circle")
                }
                .tag(1)
            }
            .tint(.pink)
        }else{
            NavigationStack() {
                HomeView().onAppear{EventManager.shared.getEvents()}
                    .navigationTitle("Inside App")
            }
        }
    }
}

#Preview {
    Routes()
}
