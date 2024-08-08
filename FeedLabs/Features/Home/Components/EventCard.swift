//
//  EventCard.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 02/08/24.
//

import SwiftUI

struct EventCard: View {
    
    @StateObject private var eventManager = EventManager.shared
    @Binding var showingInviteModal: Bool
    @Binding var selectedEvent: String

    var user: String
    
    var body: some View {
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
                    VStack{
                        ForEach(event.participants, id: \.self) { participantId in
                            if let participant = UserManager.shared.getUserById(participantId) {
                                Text("\(participant.name ?? "")")
                                    .font(.system(size: 10, weight: .light))
                            }
                        }
                    }
                    if event.owners.contains(user) {
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
                            Text("Apagar")
                        }
                    }
                }
                .frame(minWidth: 370)
                .background(Color.gray).cornerRadius(10)
            }
        }
    }
}
