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
                        //tag event: EventType
                        
                        
                        if let name = event.name {
                            Text("\(name)")
                                .font(.system(size: 32 ,weight: .bold))
                        }
                        
                        HStack{
                            ForEach(event.participants, id: \.self) { participantId in
                                if let participant = UserManager.shared.getUserById(participantId) {
                                    Text("\(participant.name ?? "")")
                                        .font(.system(size: 10, weight: .light))
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
//                        Text("ID: \(event.id ?? "")")
//                            .font(.system(size: 10,weight: .light))
                    }.padding()
                    
                    if event.owners.contains(user) {
                        Button {
                            selectedEvent = event.id!
                            showingInviteModal.toggle()
                        }label: {
                            Image(systemName: "person.badge.plus")
                                .foregroundStyle(Color.cyan)
                        }
                        Button {
                            if let id = event.id {
                                eventManager.deleteEvent(id)
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                .frame(maxWidth: 370)
                .background(Color.gray).cornerRadius(10)
            }
            .shadow(color: .black, radius: 2, x: 1, y:2)
        }
    }
}


struct MeetEventView: View {
    var body: some View {
        Text("teste")
    }
}
