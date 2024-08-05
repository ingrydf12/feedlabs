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
    case home
}


class AuthCoordinator: ObservableObject {
    
    @Published var currentScreen: AuthScreen = .entry

    // As telas já instanciadas
    var entryView: EntryView?
    var loginView: LoginView?
    var registerView: RegisterView?
    var homeView: HomeView?

    init() {
        // Instancie as views apenas uma vez
        entryView = EntryView(coordinator: self)
        loginView = LoginView(coordinator: self)
        registerView = RegisterView(coordinator: self)
        homeView = HomeView()
    }

    func navigateTo(screen: AuthScreen) {
        currentScreen = screen
    }

    func loginSuccessful() {
        currentScreen = .home
    }

}

