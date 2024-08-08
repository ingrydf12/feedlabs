// =)

import SwiftUI

struct EventCard: View {
    @StateObject private var eventManager = EventManager.shared
    @Binding var showingInviteModal: Bool
    @Binding var selectedEvent: String
    var user: String

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(eventManager.events ?? []) { event in
                HStack(spacing: 30) {
                    VStack(alignment: .leading) {
                        if let name = event.name {
                            Text(name)
                            //Change font to Tahoma 32 (title)
                                .font(.system(size: 32, weight: .bold))
                        }
                        
                        HStack {
                            ForEach(event.participants, id: \.self) { participantId in
                                if let participant = UserManager.shared.getUserById(participantId) {
                                    Text(participant.name ?? "")
                                        .font(.system(size: 10, weight: .light))
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .trailing ,spacing: 15) {
                        //TAG EVENT: EventType
                        Text(event.type.rawValue)
                            .font(.caption)
                            .padding(5)
                            .foregroundStyle(Color.darkAqua) //Change name to "Primary Color"" or Action
                            .background(Color.fordBlue.opacity(0.2)) //Change color to "Terciary"
                            .cornerRadius(10)

                        //Must to appear when (Team Details)
                        //Image(systemName: "plus.app")
                        
                        HStack {
                            if event.owners.contains(user) {
                                Button {
                                    selectedEvent = event.id ?? ""
                                    showingInviteModal.toggle()
                                } label: {
                                    Image(systemName: "person.badge.plus")
                                        .foregroundColor(.darkAqua)
                                }
                                Button {
                                    if let id = event.id {
                                        eventManager.deleteEvent(id)
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        //TAG EVENT: Date Formatter
                        Text(Self.dateFormatter.string(from: event.date ?? Date()))
                            .font(.caption)
                            .padding(5)
                            .foregroundStyle(Color.darkAqua) //Change name to "Primary Color"" or Action
                            .background(.fordBlue.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(maxWidth: 350)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
            }
        }
    }
}

struct MeetEventView: View {
    var body: some View {
        Text("teste")
    }
}
