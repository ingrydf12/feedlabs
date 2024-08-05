//
//  LoginView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct LoginView: View {
    
    let coordinator: AuthCoordinator

    var body: some View {
        Button("Fazer Log In") {
            coordinator.loginSuccessful()
        }
        Button("Register") {
            coordinator.navigateTo(screen: .register)
        }
        Button("Recover Password") {
            coordinator.navigateTo(screen: .passwordRecovery)
        }
    }
}

//#Preview {
//    LoginView()
//}
