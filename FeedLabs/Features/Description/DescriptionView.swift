//
//  DescriptionView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 13/08/24.
//

import SwiftUI

struct DescriptionView: View {
    private var viewModel: DescriptionViewModel
    @Environment(\.dismiss) var dismiss
    
    init(team: Team? = nil, meet: Event? = nil) {
        if let team = team {
            viewModel = DescriptionViewModel(team: team)
        } else {
            viewModel = DescriptionViewModel(meet: meet ?? Event(isPrivate: true, participants: [], owners: [], type: .talk))
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            
            detailsView
            
            if viewModel.userCanEdit {
                editButtons
            }
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
    
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Descrição")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(viewModel.name)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                if viewModel.isMeetDescription {
                    Text(viewModel.type?.rawValue ?? EventType.meet.rawValue)
                        .font(.tahoma(.regular, size: 16))
                        .padding(5)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        )
                }
            }
            .frame(maxWidth: .infinity)
            
            Text(viewModel.description)
                .font(.subheadline)
                .foregroundColor(.black)
            
            dateTimeView
            if let doneAt = viewModel.doneAt {
                doneAtView(doneAt: doneAt)
            }
            participantsView
            organizersView
        }
        .padding(20)
    }
    
    private var dateTimeView: some View {
        Group {
            HStack(alignment: .center) {
                Image(systemName: "calendar")
                    .foregroundColor(.black)
                Text(viewModel.dateFormatter.string(from: viewModel.date ?? Date()))
                    .font(.tahoma(.regular, size: 16))
                    .foregroundColor(.black)
            }
            
            HStack(alignment: .center) {
                Image(systemName: "clock")
                    .foregroundColor(.black)
                Text(viewModel.timeFormatter.string(from: viewModel.date ?? Date()))
                    .font(.tahoma(.regular, size: 16))
                    .foregroundColor(.black)
            }
        }
    }
    
    private func doneAtView(doneAt: Date) -> some View {
        HStack(alignment: .center) {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.black)
            Text(viewModel.dateFormatter.string(from: doneAt))
                .font(.tahoma(.regular, size: 16))
                .foregroundColor(.black)
        }
    }
    
    private var participantsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Participantes:")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            ForEach(viewModel.participants, id: \.self) { participantId in
                if let participant = UserManager.shared.getUserById(participantId) {
                    Text(participant.name ?? "")
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private var organizersView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Organizadores:")
                .font(.headline)
                .foregroundColor(.black)
            
            ForEach(viewModel.owners, id: \.self) { participantId in
                if let participant = UserManager.shared.getUserById(participantId) {
                    Text(participant.name ?? "")
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private var editButtons: some View {
        Group {
            if viewModel.isMeetDescription {
                Button("Convidar para a reunião") {
                    dismiss()

                }
                .buttonStyle(PrimaryButton())
                Button("Cancelar reunião") {
                    viewModel.deleteMeet()
                    dismiss()
                }
                .padding(.top, -15)
                .buttonStyle(SecondaryButton())
            } else {
                Button("Editar Team") {
                    dismiss()
                }
                .buttonStyle(SecondaryButton())
            }
        }
    }
}

#Preview {
    DescriptionView()
}
