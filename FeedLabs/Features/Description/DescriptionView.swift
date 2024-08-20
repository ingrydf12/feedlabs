//
//  DescriptionView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 13/08/24.
//

import SwiftUI

struct DescriptionView: View {
    
    private var isMeetDescription = false
    @StateObject private var viewModel: DescriptionViewModel
    @State var userManager = UserManager.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    init(team: Team? = nil, meet: Event? = nil) {
        if let team = team {
            _viewModel = StateObject(wrappedValue: DescriptionViewModel(team: team))
        } else {
            _viewModel = StateObject(wrappedValue: DescriptionViewModel(meet: meet ?? Event(isPrivate: true, participants: [], owners: [], type: .talk)))
            self.isMeetDescription = true
        }
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.accent)
//                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Descrição")
                        .font(.headline)
//                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("\(viewModel.name)")
                            .font(.system(size: 40, weight: .bold))
//                            .foregroundColor(.black)
                        Spacer()
                        if isMeetDescription {
                            Text(viewModel.type?.rawValue ?? EventType.meet.rawValue)
                                .font(.tahoma(.regular, size: 16))
                                .padding(5)
//                                .foregroundStyle(Color.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("\(viewModel.description)")
                        .font(.subheadline)
//                        .foregroundColor(.black)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
//                            .foregroundStyle(Color.black)
                        Text(viewModel.dateFormatter.string(from: viewModel.date ?? Date()))
                            .font(.tahoma(.regular, size: 16))
//                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                    }
                    
                    HStack(alignment: .center) {
                        Image(systemName: "clock")
//                            .foregroundStyle(Color.black)
                        Text(viewModel.timeFormatter.string(from: viewModel.date ?? Date())) // Hora formatada
                            .font(.tahoma(.regular, size: 16))
//                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                    }
                    
                    if let date = viewModel.date {
                        HStack(alignment: .center) {
                            Image(systemName: "checkmark.circle")
//                                .foregroundStyle(Color.black)
                            Text(viewModel.dateFormatter.string(from: date)) // Data em que foi feito
                                .font(.tahoma(.regular, size: 16))
//                                .foregroundStyle(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Participantes:")
                            .font(.system(size: 18,weight: .bold))
//                            .foregroundColor(.black)
                        
                        ForEach(viewModel.participants, id: \.self) { participantId in
                            if let participant = userManager.getUserById(participantId) {
                                Text(participant.name ?? "")
                                    .font(.body)
//                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Organizadores:")
                            .font(.headline)
//                            .foregroundColor(.black)
                        
                        ForEach(viewModel.owners, id: \.self) { participantId in
                            if let participant = userManager.getUserById(participantId) {
                                Text(participant.name ?? "")
                                    .font(.body)
//                                    .foregroundColor(.black)
                            }
                        }
                    }
                    if isMeetDescription && viewModel.userCanEdit {
                        if let meet = viewModel.meet {
                            NavigationLink(destination: InviteMember(toMeet: meet)){
                                Text("Convidar para a reunião")
                            }.buttonStyle(PrimaryButton())
                        }
                        Button("Cancelar reunião"){
                            viewModel.deleteMeet()
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        .padding(.top,-15)
                        .buttonStyle(SecondaryButton())
                    }else if viewModel.userCanEdit {
                        NavigationLink(destination: EditTeamView(team: viewModel.team)){
                            Text("Editar Team")
                        }.buttonStyle(SecondaryButton())
                    }
                    
                }.padding(20)
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DescriptionView()
}
