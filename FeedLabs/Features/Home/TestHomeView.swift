//
//  HomeView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI

struct TestHomeView: View {
    
    @StateObject var userManager = UserManager.shared
    
    @State private var showingAddEventModal = false
    @State private var showingInviteModal = false
    @State private var selectedEvent: String = ""
    
    var body: some View {
        if let user = UserManager.shared.user {
            VStack{
                //Debug
                Text("ID: \(user.id ?? "nil")")
                Text("NAME: \(user.name ?? "nil")")
                Text("EMAIL: \(user.email ?? "nil")")
                Text("ROLE: \(user.role?.rawValue ?? "nil")")
                
                HStack{
                    Button(action: {
                        AuthManager.shared.signOut()
                    }, label: {
                        VStack{
                            Text("Sair").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,10)
                        }.background(Color.pink).cornerRadius(18)
                    })
                    Spacer()
                    Button(action: {
                        showingAddEventModal.toggle()
                    }, label: {
                        VStack{
                            Text("New Event").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,10)
                        }.background(Color.pink).cornerRadius(18)
                    })
                    Spacer()
                    Button(action: {
                        EventManager.shared.getEvents()
                    }, label: {
                        VStack{
                            Text("Load").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,10)
                        }.background(Color.pink).cornerRadius(18)
                    })
                    Button(action: {
                        UserManager.shared.deleteLoggedInUser()
                    }, label: {
                        VStack{
                            Text("Apagar User").foregroundStyle(Color.white)
                                .padding()
                                .padding(.horizontal,10)
                        }.background(Color.pink).cornerRadius(18)
                    })
                }.padding(.horizontal,20)
                
                EventCard(showingInviteModal: $showingInviteModal, selectedEvent: $selectedEvent, user: user.id ?? "")
                
                Text("Convites Recebidos")
                    .font(.headline)
                    .padding(.top)
                
                InviteCardView(user: user.id ?? "")
                
            }.sheet(isPresented: $showingAddEventModal) {
                AddEventView()
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
    TestHomeView()
}
