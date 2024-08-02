//
//  InviteUsersView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 01/08/24.
//

import SwiftUI

struct InviteUsersView: View {
    
    @Binding var event: String
    
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack {
                Text("Convide usuários para o evento \(event)")
                    .font(.headline)
                    .padding()
                
                List(userManager.users) { user in
                    HStack {
                        Text(user.name ?? "Usuário Desconhecido")
                        Spacer()
                        Button(action: {
                            if let userId = user.id {
                                inviteManager.createInvite(for: event, to: userId)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Convidar")
                        }
                    }
                }
                
                Button("Fechar") {
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding()
        }
    }
}
