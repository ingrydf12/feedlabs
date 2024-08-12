// =)

import SwiftUI

struct EventCard: View {
    @StateObject private var eventManager = EventManager.shared
    @Binding var showingInviteModal: Bool
    @Binding var selectedEvent: String
    var user: String

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(eventManager.events) { event in
                //MARK: - Event Details
                HStack(spacing: 30) {
                    //Título do evento
                    VStack(alignment: .leading) {
                        if let name = event.name {
                            Text(name)
                            //Change font to Tahoma 32 (title)
                                .font(.tahoma(.bold, size: 32))
                        }
                        
                        //Creator
                        if let firstOwnerId = event.owners.first,
                           let owner = UserManager.shared.getUserById(firstOwnerId) { // Obtém o dono correspondente ao ID
                            Text(owner.name ?? "") // Exibe o nome do dono
                                .font(.tahoma(.regular, size: 12))
                                .multilineTextAlignment(.center)
                        }
                        
                        //Texto bonito lá pra participantes do evento
                        HStack {
                            if let firstParticipantId = event.participants.first,
                               let firstParticipant = UserManager.shared.getUserById(firstParticipantId) {
                                
                                let remainingParticipantsCount = event.participants.count - 1
                                
                                Text("\(firstParticipant.name ?? "") e mais \(remainingParticipantsCount) pessoa\(remainingParticipantsCount > 1 ? "s" : "")")
                                    .font(.tahoma(.regular, size: 14))
                                    .multilineTextAlignment(.leading)
                            }
                        }


                    }
                    
                    
                    .padding()
                    
                    VStack(alignment: .trailing ,spacing: 15) {
                        //TAG EVENT: EventType
                        Text(event.type.rawValue)
                            .font(.tahoma(.regular, size: 16))
                            .padding(5)
                            .foregroundStyle(Color.black) //Change name to "Inactive color" or Black
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )

                        //MARK: - Must to appear when (Team Details)
                        //Image(systemName: "plus.app")
                        
//                        HStack {
//                            if event.owners.contains(user) {
//                                Button {
//                                    selectedEvent = event.id ?? ""
//                                    showingInviteModal.toggle()
//                                } label: {
//                                    Image(systemName: "person.badge.plus")
//                                        .foregroundColor(.darkAqua)
//                                }
//                                Button {
//                                    if let id = event.id {
//                                        eventManager.deleteEvent(id)
//                                    }
//                                } label: {
//                                    Image(systemName: "trash.fill")
//                                        .foregroundColor(.red)
//                                }
//                            }
//                        }
                        
                        //MARK: - TAG EVENT: Date Formatter
                        HStack (alignment: .center){

                            Image(systemName: "calendar")
                                .foregroundStyle(Color.black)
                            Text(Self.dateFormatter.string(from: event.date ?? Date()))
                                .font(.tahoma(.regular, size: 16))
                                .foregroundStyle(Color.black)
                                .cornerRadius(10)
                        }
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

