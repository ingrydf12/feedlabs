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
        VStack(spacing: 20){
            //header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.accent)
                }
                Spacer()
                Text(isEditMode ? "Editar Team": "Criar Team")
                    .font(.headline)
//                    .foregroundColor(.black)
                Spacer()
            }.scrollDisabled(true)
            .padding(.horizontal)
            
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 20) {
                    // Event Name and Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nome")
                        TextField("Insira o nome do evento", text: $viewModel.name)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                        Text("Descrição")
                        TextField("Insira uma descrição sobre o evento", text: $viewModel.description)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Participants Section
                    ParticipantsList(selectedParticipants: $viewModel.selectedParticipants, type: $viewModel.type)
                        .padding(.horizontal)
                    
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
//                            .padding(.top,-15)
                    }
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    EditTeamView(team: Team(name: "time 1"))
}
