//
//  AuthRouter.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 06/08/24.
//

import SwiftUI

struct AuthRoutes: View {
    
    @StateObject private var authCoordinator = AuthCoordinator()
    
    var body: some View {
        switch authCoordinator.currentScreen {
            case .entry:
                authCoordinator.entryView
            case .login:
                authCoordinator.loginView
            case .register:
                authCoordinator.registerView
            case .passwordRecovery:
                authCoordinator.recoverPasswordView
            case .sucessRedefView:
                authCoordinator.sucessRedefView
        }
    }
}

#Preview {
    AuthRoutes()
}
