//
//  NewTeamView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import SwiftUI

struct NewTeamView: View {
    
    @ObservedObject var viewModel: TeamsViewModel
    
    var body: some View {
        VStack{
            Text("Nome:")
            HStack{
                TextField("", text: $viewModel.name, prompt: Text("name").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
            Button(action: {
                viewModel.createTeam()
            }, label: {
                VStack{
                    Text("create").foregroundStyle(Color.white).bold().padding()
                }.background(Color.pink).cornerRadius(18)
            })
        }
    }
}
