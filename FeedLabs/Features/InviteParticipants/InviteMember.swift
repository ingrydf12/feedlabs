import SwiftUI

struct InviteMember: View {
    @State private var searchItem: String = ""
    @Binding var event: EventType  // Usando EventType diretamente
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Filtragem
    private var filteredUsers: [User] {
        if searchItem.isEmpty {
            // Retorna todos os usuários se não houver pesquisa
            return userManager.users
        } else {
            // Filtra usuários com base na pesquisa
            return userManager.users.filter { user in
                user.name?.localizedStandardContains(searchItem) ?? false
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchItem, placeholder: "Buscar membros")
            
            // MARK: - Scroll com users
            ScrollView {
                VStack {
                    ForEach(filteredUsers, id: \.id) { user in
                        // Verifica se o usuário não é o usuário atual
                        if userManager.user?.id != user.id {
                            UserInviteCard(user: user, event: event)
                                .onTapGesture {
                                    inviteManager.createInvite(for: event.rawValue, to: user.id ?? "")
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
