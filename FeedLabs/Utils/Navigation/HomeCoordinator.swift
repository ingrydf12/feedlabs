//
//  HomeCoordinator.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import Foundation
import SwiftUI

class HomeCoordinator: ObservableObject {
    
    func start() -> some View {
        Routes(coordinator: self)
    }

    func navigateToTeams() -> some View {
        TeamsView()
    }

    func navigateToHome() -> some View {
        HomeView()
    }

    func navigateToChats() -> some View {
        ChatsView()
    }
}
