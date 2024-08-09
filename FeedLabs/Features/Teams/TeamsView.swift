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
            VStack {
                HStack{
                    Text("Meets") // buscar nos eventos do usuario eventos do tipo team meet
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                    Button {
                        print("new team meet")
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.darkAqua)
                    }
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
            .padding(.vertical,15)
            .padding(.horizontal,20)
            
        }
    }
}

#Preview {
    TeamsView()
}
