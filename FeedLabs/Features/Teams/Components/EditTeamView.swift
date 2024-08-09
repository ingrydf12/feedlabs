//
//  NewTeamView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import SwiftUI

struct EditTeamView: View {
    
    var isEditMode: Bool = false
    @StateObject private var viewModel: EditViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    init(team: Team? = nil){
        if let team = team {
            _viewModel = StateObject(wrappedValue: EditViewModel(team: team))
            self.isEditMode = true
        }else{
            _viewModel = StateObject(wrappedValue: EditViewModel())
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left").font(.system(size: 26)).foregroundColor(.darkAqua)
                })
                Spacer()
                Text(isEditMode ? "Editar Team" :"Criar Team").foregroundColor(.darkAqua)
                Spacer()
            }
            .padding(.horizontal,20)
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading ){
                    Text("Nome do Time:")
                    HStack{
                        TextField("", text: $viewModel.name, prompt: Text("Digite o nome").foregroundColor(.white))
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    .frame(width: 344, height: 46)
                    .background(Color.gray.cornerRadius(10.0))
                    
                    Text("Descrição:")
                    HStack{
                        TextField("", text: $viewModel.description, prompt: Text("Escreva a descrição").foregroundColor(.white))
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    .frame(width: 344, height: 46)
                    .background(Color.gray.cornerRadius(10.0))
                    
                }.padding(.top)
                Text("Participantes:").padding()
                ForEach(viewModel.users) { user in
                    HStack {
                        Text(user.name ?? "").padding(.leading,5)
                        Spacer()
                        if viewModel.selectedParticipants.contains(user.id ?? "") {
                            // Value: Selected
                            Image(systemName: "person.fill.checkmark")
                                .foregroundStyle(Color.blue)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                                .padding(.trailing)
                        } else {
                            //Value: Default
                            Image(systemName: "person.badge.plus")
                                .foregroundColor(.cyan)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                                .padding(.trailing)
                        }
                    }
                    .contentShape(Rectangle())
                    .frame(height: 48)
                    .onTapGesture {
                        if viewModel.selectedParticipants.contains(user.id ?? "") {
                            viewModel.selectedParticipants.remove(user.id ?? "")
                        } else {
                            viewModel.selectedParticipants.insert(user.id ?? "")
                        }
                    }
                }
                
                Button(isEditMode ? "Editar Team" : "Criar Team"){
                    if isEditMode {
                        viewModel.editTeam()
                    }else {
                        viewModel.createTeam()
                    }
                    presentationMode.wrappedValue.dismiss()
                }.buttonStyle(PrimaryButton())
                if isEditMode {
                    Button("Apagar Team"){
                        viewModel.deleteTeam()
                        presentationMode.wrappedValue.dismiss()

                    }.buttonStyle(SecondaryButton())
                }
            }
            .padding()
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    EditTeamView(team: Team(name: "time 1"))
}
