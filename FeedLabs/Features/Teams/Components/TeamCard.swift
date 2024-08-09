//
//  TeamCard.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import SwiftUI

struct TeamCard: View {
    
    let team: Team
    let role: Role
    
    private let maxParticipantsToShow = 3
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment:.top){
                VStack(alignment: .leading){
                    HStack{
                        Text("No prazo")
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                    }.overlay{
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                            .foregroundColor(.green)
                    }
                    
                    Text("\(team.name)")
                        .font(.system(size: 32,weight: .bold))
                }
                if role == .mentor {
                    Spacer()
                    NavigationLink(destination: EditTeamView(team: team)) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                            .foregroundColor(.darkAqua)
                    }
                }else {
                    Spacer()
                }
            }.padding()
            VStack(alignment: .leading){
                HStack {
                    let participants = team.participants ?? []
                    let displayParticipants = Array(participants.prefix(maxParticipantsToShow))
                    ForEach(displayParticipants, id: \.self) { participantId in
                        if let participant = UserManager.shared.getUserById(participantId) {
                            Text("\(participant.name ?? "nnn")")
                                .font(.system(size: 16))
                        }
                    }
                    if participants.count > maxParticipantsToShow {
                        Text("e mais \(participants.count - maxParticipantsToShow)")
                            .font(.system(size: 16))
                            .italic()
                    }
                }
                Text("\(team.description ?? "")")
                    .foregroundStyle(.darkAqua)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.top,-5)
        }
        .frame(maxWidth: .infinity)
        .overlay{
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                .foregroundColor(.darkAqua)
        }
    }
}

#Preview {
    TeamCard(team: Team(name: "Time 1", participants: ["7k0h9RLmNmOqFXSGsuQsnSbBzun1"]),role: .mentor)
}