import SwiftUI

struct EventCard: View {
    
    @StateObject private var eventManager = EventManager.shared
    @Binding var showingInviteModal: Bool
    @Binding var selectedEvent: String
    //private let maxVisibleParticipants = 2 // Limite
    
    var user: String
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(eventManager.events ?? []) { event in
                HStack(spacing: 30) {
                    VStack(alignment: .leading){
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
                    }.padding()
                    
                    VStack(spacing: 15){
                        //Tag Event: EventType
                        Text(event.type.rawValue)
                            .font(.caption)
                            .padding(5)
                            .background(Color.gray.opacity(0.2)) //Mudar para Primary Color (Action)
                            .cornerRadius(10)
                        
                        HStack{
                            if event.owners.contains(user) {
                                Button {
                                    selectedEvent = event.id!
                                    showingInviteModal.toggle()
                                }label: {
                                    Image(systemName: "person.badge.plus")
                                        .foregroundStyle(Color.blue)
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
                    }
                }
                .padding()
                .frame(maxWidth: 350)
                .background(Color.white).cornerRadius(10) //Mudar para FAFAFA ()
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
