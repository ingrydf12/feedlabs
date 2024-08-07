//
//  TeamsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct TeamsView: View {
    
    @StateObject private var viewModel = TeamsViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Teams")
                        .padding(.vertical,5)
                        .padding(.horizontal,150)
                }
                .background(Color.clearGray)
                .cornerRadius(15)
                
                HStack{
                    Text("Meets") // buscar nos eventos do usuario eventos do tipo team meet
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                }
                
                HStack{
                    EmptyView()
                }
                .frame(width: 333,height: 95)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.darkAqua, lineWidth: 2)
                )
                .padding(.bottom,10)
                
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(Color.clearGray)
                    .cornerRadius(20)
                
                HStack{
                    Text("Teams")
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                }
                ScrollView(.vertical) {
                    ForEach(viewModel.teams) { team in
                        TeamCard(team: team)
                    }
                }
                NavigationLink("add", destination: NewTeamView(viewModel: viewModel))
                Spacer()
            }
            .padding(.top,15)
            .padding(.horizontal,20)
            .onAppear{
                switch UserManager.shared.user?.role {
                    case "Mentor":
                        viewModel.getAllTeams()
                    case "Student":
                    viewModel.getUserTeams()
                    default:
                    viewModel.getAllTeams()
                }
            }
            
        }
    }
}

#Preview {
    TeamsView()
}
