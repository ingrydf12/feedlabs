//
//  NewTeamView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import SwiftUI

struct NewTeamView: View {
    
    @ObservedObject var viewModel: TeamsViewModel
    @StateObject var userManager = UserManager.shared
    @State private var selectedParticipants: Set<String> = []
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left").font(.system(size: 32)).foregroundColor(.darkAqua)
                })
                Spacer()
                Text("Criar Team").foregroundColor(.darkAqua)
                Spacer()
            }
            .padding(.horizontal,20)
            
            VStack(alignment: .leading ){
                Text("Nome do Time:")
                HStack{
                    TextField("", text: $viewModel.name, prompt: Text("Digite o nome").foregroundColor(.white))
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                }
                .frame(width: 344, height: 46)
                .background(Color.gray.cornerRadius(10.0))
                
                Text("Descrição:")
                HStack{
                    TextField("", text: $viewModel.description, prompt: Text("Escreva a descrição").foregroundColor(.white))
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                }
                .frame(width: 344, height: 46)
                .background(Color.gray.cornerRadius(10.0))
                
            }.padding(.top)
            List(userManager.users) { user in
                if userManager.user?.id != user.id {
                    HStack {
                        Text(user.name ?? "")
                        Spacer()
                        if selectedParticipants.contains(user.id ?? "") {
                            // Value: Selected
                            Image(systemName: "person.fill.checkmark")
                                .foregroundStyle(Color.blue)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        } else {
                            //Value: Default
                            Image(systemName: "person.badge.plus")
                                .foregroundColor(.cyan)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        }
                    }
                    .contentShape(Rectangle())
                    .frame(height: 48)
                    .onTapGesture {
                        if selectedParticipants.contains(user.id ?? "") {
                            selectedParticipants.remove(user.id ?? "")
                        } else {
                            selectedParticipants.insert(user.id ?? "")
                        }
                    }
                }
            }
            Button(action: {
                viewModel.participants = Array(selectedParticipants)
                viewModel.createTeam()
            }, label: {
                Text("Criar")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(.darkAqua)
                    .cornerRadius(18)
            })
        }.navigationBarBackButtonHidden()
    }
}
