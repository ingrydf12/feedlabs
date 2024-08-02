//
//  HomeView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var userManager = UserManager.shared
    @StateObject private var eventManager = EventManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    
    @State private var showingAddEventModal = false
    @State private var showingInviteModal = false
    @State private var selectedEvent: String = ""
    
    var body: some View {
        if let user = userManager.user {
            VStack{
                Text("ID: \(user.id ?? "nil")")
                Text("NAME: \(user.name ?? "nil")")
                Text("EMAIL: \(user.email ?? "nil")")
                Text("ROLE: \(user.role ?? "nil")")
                HStack{
                    Button(action: {
                        AuthManager.shared.signOut()
                    }, label: {
                        VStack{
                            Text("Sair").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,30)
                        }.background(Color.pink).cornerRadius(18)
                    })
                    Spacer()
                    Button(action: {
                        showingAddEventModal.toggle()
                    }, label: {
                        VStack{
                            Text("New Event").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,30)
                        }.background(Color.pink).cornerRadius(18)
                    })
                }.padding(.horizontal,20)
                
                ScrollView(.vertical) {
                    ForEach(eventManager.events ?? []) { event in
                        HStack {
                            VStack(alignment: .leading){
                                if let name = event.name {
                                    Text("\(name)")
                                        .font(.system(size: 15,weight: .bold))
                                }
                                Text("ID: \(event.id ?? "")")
                                    .font(.system(size: 10,weight: .light))
                            }.padding()
                            
                            if let date = event.date {
                                Text("\(date)")
                                    .font(.system(size: 10,weight: .light))
                                    .padding()
                            }
                            if event.owners.contains(user.id ?? ""){
                                Button {
                                    selectedEvent = event.id!
                                    showingInviteModal.toggle()
                                } label: {
                                    Text("Convidar")
                                }
                                Button {
                                    if let id = event.id {
                                        eventManager.deleteEvent(id)
                                    }
                                } label: {
                                    Text("del")
                                }
                            }
                        }
                        .background(Color.gray).cornerRadius(10)
                    }
                }
                
                Text("Convites Recebidos")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView(.vertical) {
                    ForEach(inviteManager.invites) { invite in
                        VStack(alignment: .leading) {
                            Text("Evento: \(invite.eventId ?? "Desconhecido")")
                            Text("De: \(invite.from ?? "Desconhecido")")
                            Text("Status: \(invite.status?.rawValue ?? "Desconhecido")")
                            HStack {
                                if invite.to == user.id {
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
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                    }
                }
                
            }.sheet(isPresented: $showingAddEventModal) {
                AddEvent()
            }.sheet(isPresented: $showingInviteModal) {
                InviteUsersView(event: $selectedEvent)
            }
        } else {
            ProgressView()
                .frame(width: 100, height: 150, alignment: .center)
        }
    }
}



#Preview {
    HomeView()
}
