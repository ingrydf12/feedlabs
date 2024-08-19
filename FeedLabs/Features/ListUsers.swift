//
//  ListUsers.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 01/08/24.
//

import SwiftUI

class CreatingNewMessageView: ObservableObject{
    @Published var users = [ChatUser]()
    @Published var erroMessage: String = ""
    @State var userManager = UserManager.shared
    
    init(){
        fetchAllUsers()
    }
    
    func fetchAllUsers(){
        print(UserManager.shared.users)
        userManager.users.forEach({ user in
            print(user)
            let chatUser = ChatUser.init(user: user)
            if chatUser.id != AuthManager.shared.userId {
                self.users.append(chatUser)
                
            }
        })
    }
}

struct ListUsers: View {
    @State var users = [User]()

    @State var isSearching: Bool = false
    @State var search: Bool = false
    @State var userManager = UserManager.shared
    @State private var isPrivate: Bool = false
    //@State private var hideToolbarItem = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        NavigationView{
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
                }//.padding()
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Image("CatListUsers")
                        .resizable()
                        .frame(width: 300, height: 300)
                        
                    Text("Comece um chat pesquisando participantes na barra de busca")
                        .font(.headline)
                        .frame(maxWidth: 300)
                        .foregroundColor(.gray)
                        
                }
               
                if !(userManager.searchText == "") &&   userManager.isSearchingUser {
                   
                    Section(header: Text("Selecionar usuário")){
                        ForEach(userManager.searchUsers){ user in
                            NavigationLink(destination: ChatsView(user: user)){
                                HStack{
                                    Image(systemName: "person.circle.fill")
                                    Text(user.name ?? "")
                                }
                            }
                        }
                    }
                }else{
                    
                    Section(header: Text("Selecionar usuário")){
                        ForEach(userManager.filteredUsers){ user in
                            NavigationLink(destination: ChatsView(user: user)){
                                Image(systemName: "person.circle.fill")
                                    .font(.largeTitle)
                                Text(user.name ?? "")
                            }
                        }
                        .padding(4)
                    
                       
                    }.onAppear{
                        userManager.isSearchingUser = false
                    }
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text("Chats").font(.largeTitle)
                        .padding(9)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {}){
                      Image(systemName: "plus.circle.fill")
                            .padding(6)
                            .cornerRadius(30)
                            .font(.title2)
                            //.bold()

                    }.foregroundStyle(Color("darkAqua"))

                }
            }
        }
        
    }
}


#Preview {
    ListUsers()
}
