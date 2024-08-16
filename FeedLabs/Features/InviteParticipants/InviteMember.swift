//
// InviteMember.swift -> ?
// FeedLabs
// Created by Ingryd Cordeiro Duarte on 13/08/24.
//

import SwiftUI

struct InviteMember: View {
    var user: User
    @State private var searchItem: String = ""
    @Binding var event: EventType 
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Filtragem
    private var filteredUsers: [User] {
        if searchItem.isEmpty {
            return userManager.users
        } else {
            return userManager.users.filter { user in
                user.name?.localizedStandardContains(searchItem) ?? false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchItem, placeholder: "Buscar membros")
                
                // MARK: - Scroll com users
                ScrollView {
//                    VStack {
//                        ForEach(filteredUsers, id: \.id) { user in
//                            if (userManager.user?.id)! != user.id {
//                                UserInviteCard(user: user, event: event)
//                                    .onTapGesture {
//                                        inviteManager.createInvite(for: event.id, to: user.id ?? "")
//                                    }
//                            }
//                        }
//                    }
                }
            }
            .navigationTitle("Convidar Membros")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
            .padding()
        }
    }
}
