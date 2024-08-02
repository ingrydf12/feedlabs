//
//  InviteUsersView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 01/08/24.
//

import SwiftUI

struct InviteUsersView: View {
    
    var event: String
    
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager()
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
                        }) {
                            Text("Convidar")
                        }
                    }
                }
                
                Button("Fechar") {
                    presentationMode.wrappedValue.dismiss()
                }
            }.onAppear{print(1)}
                .padding()
        }
    }
}


#Preview {
    InviteUsersView(event: "SggpSZCGxvmWokq4mmmf")
}
