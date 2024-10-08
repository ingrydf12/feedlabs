//
//  ListUsers.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 01/08/24.
//

import SwiftUI

struct ListUsers: View {
    @State var isSearching: Bool = false
    @State var search: Bool = false
    @State var userManager = UserManager.shared
    @State private var isPrivate: Bool = false
    //@State private var hideToolbarItem = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            HStack{
                TextField("", text: $userManager.searchText, prompt: Text("Buscar").foregroundColor(.gray))
                         .autocapitalization(.none)
                         .foregroundColor(.gray)
                        
                 Button(action: {
                     userManager.isSearchingUser = true
                 }, label: {
                     Image(systemName: "magnifyingglass")
                         .foregroundColor(.gray)
                 })
            }
            if !(userManager.searchText == "") &&   userManager.isSearchingUser {
               
                Section(header: Text("Selecionar usuário")){
                    ForEach(userManager.searchUsers){ user in
                        NavigationLink(destination: self.getChatWithUser(userId: user.id ?? "" ) != nil ?
                           ChatsView(user: user, chat: self.getChatWithUser(userId: user.id ?? "" )) :
                           ChatsView(user: user)){
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .foregroundStyle(.accent)
//                                    .foregroundColor(Color("darkAqua") )
                                    .font(.largeTitle)
                                Text(user.name ?? "")
                            }
                        }
                    }
                }
            }else{
                
                Section(header: Text("Selecionar usuário")){
                    ForEach(userManager.filteredUsers){ user in
                       
                        NavigationLink(destination: self.getChatWithUser(userId: user.id ?? "" ) != nil ?
                            ChatsView(user: user, chat: self.getChatWithUser(userId: user.id ?? "" )) :
                            ChatsView(user: user)){
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Color("darkAqua") )
                                    .font(.largeTitle)
                                Text(user.name ?? "")
                            }
                    }
                }.onAppear{
                    userManager.isSearchingUser = false
                }
            }
            
        }
        .navigationTitle("Usuários")
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        userManager.searchText = ""
                    }){
                        Image(systemName:  "chevron.backward").padding(-4)
//                        Text("Voltar")
                    }.foregroundStyle(.accent)
                        .font(.headline)
                        .padding(7)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func getChatWithUser(userId: String) -> ChatUser?{
        return ChatManager.shared.filteredChats.filter{ return $0.toUser == userId}.first
    }
}


#Preview {
    ListUsers()
}
