//
//  TeamMeetCard.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 12/08/24.
//

import SwiftUI

struct TeamMeetCard: View {
    
    var event: Event
    @State var userManager = UserManager.shared
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: DescriptionView(meet: event)){
            HStack(spacing: 30) {
                //Título do evento
                VStack(alignment: .leading,spacing: 5) {
                    if let name = event.name {
                        Text(name)
                        //Change font to Tahoma 32 (title)
                            .font(.tahoma(.bold, size: 28))
                            .padding(.leading,0)
                    }
                    
                    //Texto bonito lá pra participantes do evento
                    HStack {
                        if let firstParticipantId = event.participants.first,
                           let firstParticipant = userManager.getUserById(firstParticipantId) {
                            
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
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        )
                    //MARK: - TAG EVENT: Date Formatter
                    HStack (alignment: .center){
                        
                        Image(systemName: "calendar")
                        Text(Self.dateFormatter.string(from: event.date ?? Date()))
                            .font(.tahoma(.regular, size: 16))
                            .cornerRadius(10)
                    }
                }
            }
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: 350)
            .cornerRadius(10)
            .overlay{
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    .foregroundColor(.accent)
            }
//            .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 2)
        }
    }
}

#Preview {
    TeamMeetCard(event: Event(isPrivate: false, participants: [], owners: [], type: .teamMeet))
}
