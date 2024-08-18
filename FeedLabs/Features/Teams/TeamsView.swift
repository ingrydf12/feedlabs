//
//  TeamsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct TeamsView: View {
    
    private var viewModel = TeamsViewModel.shared //removido o @ObservableObject -> TeamsVM está como final class e @Observable 
    
    var body: some View {
        VStack {
            HStack {
                Text("Meets") // buscar nos eventos do usuario eventos do tipo team meet
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                NavigationLink(destination: AddEventView()) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.darkAqua)
                }
            }
            .padding(.bottom, 10)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    if viewModel.teamMeets.count != 0 {
                        ForEach(viewModel.teamMeets) { teamMeet in
                            TeamMeetCard(event: teamMeet)
                                .padding(.horizontal, 9)
                        }
                        .padding(.vertical)
                    } else {
                        NoEventCard()
                            .accessibilityLabel("Nenhum evento Hoje")
                            .padding()
                    }
                    
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(Color.clearGray)
                        .cornerRadius(20)
                        .padding(.vertical)

                    HStack {
                        Text("Teams")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        if viewModel.role == .mentor {
                            NavigationLink(destination: EditTeamView()) {
                                Image(systemName: "plus")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.darkAqua)
                            }
                        }
                    }
                    .padding(.bottom, 10)

                    ForEach(viewModel.teams) { team in
                        TeamCard(team: team, role: viewModel.role ?? .student)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 9)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding(.top, 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    TeamsView()
}
