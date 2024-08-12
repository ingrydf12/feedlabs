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
                            if let firstParticipantId = event.participants.first,
                               let firstParticipant = UserManager.shared.getUserById(firstParticipantId) {
                                Text(firstParticipant.name ?? "")
                                    .font(.system(size: 10, weight: .light))
                                    .multilineTextAlignment(.center)
                                
                                if event.participants.count > 1 {
                                    Text("+\(event.participants.count - 1)")
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
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )

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
                            .foregroundStyle(Color.blue) //Change name to "Inactive color
                            .background(Color.gray.opacity(0.2))
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

