//
// InviteMember.swift -> ?
// FeedLabs
// Created by Ingryd Cordeiro Duarte on 13/08/24.
//

import SwiftUI

struct InviteMember: View {
    
    @StateObject private var viewModel: InviteMemberViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(toMeet meet: Event){
        _viewModel = StateObject(wrappedValue: InviteMemberViewModel(toMeet: meet))
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Convidar Membro")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.horizontal)
            
            SearchBar(text: $viewModel.searchItem, placeholder: "Buscar membros")
            
            // MARK: - Scroll com users
            ScrollView {
                VStack {
                    ForEach(viewModel.filteredUsers) { user in
                        if viewModel.userManager.user?.id != user.id {
                            UserInviteCard(user: user, event: viewModel.event)
                        }
                    }.padding(.horizontal,9)
                }.padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}
