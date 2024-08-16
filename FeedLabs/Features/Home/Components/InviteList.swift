//
//  InviteList.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 02/08/24.
//

import SwiftUI

struct InviteList: View {
    
    @ObservedObject private var inviteManager = InviteManager.shared
    var user: String
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(inviteManager.invites) { invite in
                VStack(alignment: .leading) {
                    Text("Evento: \(invite.eventId ?? "Desconhecido")")
                    Text("De: \(UserManager.shared.getUserById(invite.from ?? "")?.name ?? "")")
                    Text("Para: \(UserManager.shared.getUserById(invite.to ?? "")?.name ?? "")")
                    Text("Status: \(invite.status?.rawValue ?? "Desconhecido")")
                    if(invite.status == .pendente){
                        HStack {
                            if invite.to == user {
                                Button("Aceitar") {
                                    inviteManager.updateInviteStatus(invite, status: .aceito)
                                }
                                Button("Recusar") {
                                    inviteManager.updateInviteStatus(invite, status: .recusado)
                                }
                            }else {
                                Button("Cancelar") {
                                    inviteManager.updateInviteStatus(invite,status: .cancelado)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
            }
        }
    }
}
