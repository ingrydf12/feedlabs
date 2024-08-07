//
//  TeamCard.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import SwiftUI

struct TeamCard: View {
    
    let team: Team
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("No prazo")
                    .padding(.horizontal,14)
                    .padding(.vertical,4)
            }.overlay{
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    .foregroundColor(.green)
            }
            .padding(.leading,-6)
            
            Text("\(team.name)")
                .font(.system(size: 32,weight: .bold))
                .padding(.bottom,4)
            
            Text("Participantes:\(team.participants ?? ["nenhum"])")
            Text("\(team.description ?? "")")
                .foregroundStyle(.darkAqua)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,30)
        .overlay{
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                .foregroundColor(.darkAqua)
        }
    }
}

#Preview {
    TeamCard(team: Team(name: "Time 1"))
}
