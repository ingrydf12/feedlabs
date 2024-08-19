//
//  TeamsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct TeamsView: View {
    
    @ObservedObject private var viewModel = TeamsViewModel.shared
    @State private var userManager = UserManager.shared
    
    var body: some View {
        VStack {
            HStack{
                Text("Meets") // buscar nos eventos do usuario eventos do tipo team meet
                    .font(.system(size: 24,weight: .bold))
                Spacer()
                NavigationLink(destination: AddEventView()) {
                    Image(systemName: "plus")
                        .font(.system(size: 20,weight: .semibold))
                        .foregroundColor(.darkAqua)
                }
            }
            ScrollView(.vertical,showsIndicators: false) {
                if viewModel.teamMeets.count != 0 {
                    VStack{
                        ForEach(viewModel.teamMeets) { teamMeet in
                            TeamMeetCard(event: teamMeet)
                        }
                        .padding(.horizontal,9)
                    }.padding(.vertical)
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
                VStack{
                    ForEach(viewModel.teams) { team in
                        TeamCard(team: team,role: viewModel.role ?? .student)
                    }
                }
                .padding(.vertical,7)
                .padding(.horizontal,9)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .padding(.top,5)
        .padding(.horizontal,20)
    }
}

#Preview {
    TeamsView()
}
