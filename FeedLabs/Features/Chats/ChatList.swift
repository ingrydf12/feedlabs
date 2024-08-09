//
//  ChatList.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 09/08/24.
//

import SwiftUI

struct ChatList: View {
    @State var isSearching: Bool = false
    @StateObject var userManager = UserManager.shared
    
    var body: some View {
        NavigationView{
            Form{
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
                
                VStack{
                    Image("CatListUsers")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    Text("Comece um chat pesquisando participantes na barra de busca")
                        .font(.headline)
                        .frame(maxWidth: 260)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                }
                
            }
            //.navigationTitle("Chats")
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
                    }.onDisappear{
                        userManager.searchText = ""
                    }
                }
            }
        }
    }
}

#Preview {
    ChatList()
}
