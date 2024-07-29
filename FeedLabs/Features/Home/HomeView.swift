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
    @State private var showingAddEventModal = false
    
    var body: some View {
        if userManager.user != nil {
            VStack{
                Text("ID: \(userManager.user?.id ?? "nil")")
                Text("NAME: \(userManager.user?.name ?? "nil")")
                Text("EMAIL: \(userManager.user?.email ?? "nil")")
                Text("ROLE: \(userManager.user?.role ?? "nil")")
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
                        }
                        .background(Color.gray).cornerRadius(10)
                    }
                }
            }.sheet(isPresented: $showingAddEventModal) {
                AddEvent()
            }
        }else {
            ProgressView()
                .frame(width: 100, height: 150, alignment: .center) 
        }
    }
}

#Preview {
    HomeView()
}
