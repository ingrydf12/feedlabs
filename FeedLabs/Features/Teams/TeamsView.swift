//
//  TeamsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct TeamsView: View {
    
    @StateObject var viewModel = TeamsViewModel.shared
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Text("Meets") // buscar nos eventos do usuario eventos do tipo team meet
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                    NavigationLink(destination: AddEvent()) {
                        Image(systemName: "plus")
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.darkAqua)
                    }
                }
                if viewModel.teamMeets.count != 0 {
                    ScrollView(.vertical) {
                        ForEach(viewModel.teamMeets) { teamMeet in
                            Text("\(teamMeet.name ?? "nada")")
                                .font(.system(size: 16,weight: .semibold))
                        }
                        .padding(.top)
                        .padding(.horizontal,9)
                    }
                }else {
                    VStack(alignment:.center){
                        Image("imageNoEvent")
                            .resizable()
                            .frame(width: 117,height: 114)
                        Text("Parece que você não tem nenhum")
                            .font(.system(size: 16,weight: .semibold))
                        Text("evento pra hoje")
                            .font(.system(size: 16,weight: .semibold))
                        
                    }
                    .padding()
                    .accessibilityLabel("Nenhum evento Hoje")
                }
                
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(Color.clearGray)
                    .cornerRadius(20)
                
                HStack{
                    Text("Teams")
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                    if viewModel.role == .mentor {
                        NavigationLink(destination: EditTeamView()) {
                            Image(systemName: "plus")
                                .font(.system(size: 20,weight: .semibold))
                                .foregroundColor(.darkAqua)
                        }
                    }
                }
                ScrollView(.vertical) {
                    ForEach(viewModel.teams) { team in
                        TeamCard(team: team,role: viewModel.role ?? .student)
                    }
                    .padding(.top)
                    .padding(.horizontal,9)
                    .padding(.bottom,20)
                }
                Spacer()
            }
            .padding(.horizontal,20)
            
        }
    }
}

#Preview {
    TeamsView()
}
