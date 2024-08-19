//
//  InviteCardList.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 16/08/24.
//

import SwiftUI

struct InviteCardView: View {
    
    @State private var inviteManager = InviteManager.shared
    var user: String
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                ForEach(inviteManager.invites) { invite in
                    VStack(alignment: .center, spacing: 10) {
                        //Quem está convidando:
                        Text("\(UserManager.shared.getUserById(invite.from ?? "")?.name ?? "") está te convidando para um evento:")
                            .font(.tahoma(.regular, size: 14))
                            .foregroundColor(.black)
                        
                        //Event Name (ERROR)
                        Text("\(inviteManager.getEventById(eventId: invite.eventId ?? "") ?? "Desconhecido")")
                            .font(.tahoma(.bold, size: 24))
                            .foregroundColor(.primary)
                        
                        //Você
                        Text("Para: \(UserManager.shared.getUserById(invite.to ?? "")?.name ?? "")")
                            .font(.tahoma(.bold, size: 16))
                            .foregroundColor(.darkAqua)
                        
                        //Status do convite
                        Text("\(invite.status?.rawValue ?? "Desconhecido")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // Up Status
                        if invite.status == .pendente {
                            HStack {
                                if invite.to == user {
                                    Button("Aceitar") {
                                        inviteManager.updateInviteStatus(invite, status: .aceito)
                                    }
                                    .foregroundStyle(.green)
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(.trailing, 5)
                                    
                                    Button("Recusar") {
                                        inviteManager.updateInviteStatus(invite, status: .recusado)
                                    }
                                    .foregroundStyle(.red)
                                    .buttonStyle(BorderlessButtonStyle())
                                } else {
                                    Button("Cancelar") {
                                        inviteManager.updateInviteStatus(invite, status: .cancelado)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                            .padding(.top, 5)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
            .padding()
        }
    }
}
