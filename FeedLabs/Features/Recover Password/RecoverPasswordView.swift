//
//  RecoverPasswordView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 06/08/24.
//

import SwiftUI

struct RecoverPasswordView: View {
    
    let coordinator: AuthCoordinator
    
    var body: some View {
       
        Button("Voltar", action: {
            coordinator.navigateTo(screen: .login)
        })
        
        Text("Recover Password")
    }
}
