//
//  ChatList.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 09/08/24.
//

import SwiftUI

struct ChatList: View {
    @State var isSearching: Bool = false
    @StateObject var chatManager = ChatManager.shared
   
    var body: some View {
        NavigationView{
            Form{
                HStack{
                    TextField("", text: $chatManager.searchText, prompt: Text("Buscar").foregroundColor(.gray))
                        .autocapitalization(.none)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        chatManager.isSearchingUser = true
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                    })
                }
                HStack{
                    NavigationLink(destination: InvitesView()){
                        Image(systemName: "exclamationmark.bubble.circle.fill")
                            .font(.largeTitle).foregroundColor(Color("darkAqua") )
                        Text("Convites")
                    }
                }
                if !chatManager.filteredUsersByChats.isEmpty {  // !
                    if !(chatManager.searchText == "") &&   chatManager.isSearchingUser {
                        Section(header: Text("Selecionar conversa")){
                            ForEach(chatManager.filteredUsersByName){ user in
                                NavigationLink(destination: ChatsView(user: user, chat: getChatWithUser(userId: user.id ?? ""))){
                                  
                                        Image(systemName: "person.circle.fill")
                                            .font(.largeTitle).foregroundColor(Color("darkAqua") )
                                        Text(user.name ?? "")
                                    
                                }
                            }
                        }
                    }else{
                   
                        Section(header: Text("Selecionar conversa")){
                            ForEach(chatManager.filteredUsersByChats){ user in
                                NavigationLink(destination: ChatsView(user: user , chat: getChatWithUser(userId: user.id ?? ""))){
                                    Image(systemName: "person.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(Color("darkAqua") )
                                        //.cornerRadius(30)
                                    Text(user.name ?? "")
                                }
                            }
                        }.onAppear{
                            chatManager.isSearchingUser = false
                        }
                    }
                    
                }else{
                    HStack{
                        Spacer()
                        VStack(alignment: .center){
                            ProgressView()
                            Image("CatListUsers")
                                .resizable()
                                .frame(width: 300, height: 300)
                            
                            Text("Comece uma conversa clicando no botão de adicionar chat")
                                .font(.headline)
                                .frame(maxWidth: 260)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }
                        Spacer()
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text("Chats").font(.largeTitle)
                        .padding(5)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing){
                    
                    Button(action: {}){
                        NavigationLink(destination: ListUsers()){
                           
                          Image(systemName: "plus.circle.fill")
                                .padding(6)
                                .cornerRadius(30)
                                .font(.title2)

                        }.foregroundStyle(Color("darkAqua"))
                    }
                }
            }
        }
    }
    
    func getChatWithUser(userId: String) -> ChatUser{
        return ChatManager.shared.filteredChats.filter{ return $0.toUser == userId}.first ?? ChatUser()
        
    }
}

#Preview {
    ChatList()
}
