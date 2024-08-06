//
//  AuthCoordinator.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI
import Foundation

enum AuthScreen {
    case entry
    case login
    case register
    case passwordRecovery
    case sucessRedefView
}

class AuthCoordinator: ObservableObject {
    
    @Published var currentScreen: AuthScreen = .entry

    // As telas já instanciadas
    var entryView: EntryView?
    var loginView: LoginView?
    var registerView: RegisterView?
    var recoverPasswordView: RecoverPasswordView?
    var sucessRedefView: SucessRedefView?
    
    init() {
        entryView = EntryView(coordinator: self)
        loginView = LoginView(coordinator: self)
        registerView = RegisterView(coordinator: self)
        recoverPasswordView = RecoverPasswordView(coordinator: self)
        sucessRedefView = SucessRedefView(coordinator: self)
    }

    func navigateTo(screen: AuthScreen) {
        currentScreen = screen
    }
}

