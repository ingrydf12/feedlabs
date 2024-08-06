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
    @StateObject var userManager = UserManager.shared
    
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
    @StateObject var userManager = UserManager.shared
    @State private var isPrivate: Bool = false
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
                }
               
                if !(userManager.searchText == "") &&   userManager.isSearchingUser {
                   
                    Section(header: Text("Selecionar usuário")){
                        ForEach(userManager.searchUsers){ user in
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text(user.email ?? "")
                            })
                            .foregroundStyle(Color(.black))
                        }
                    }.onAppear{
                        
                    }
                }else{
                    Section(header: Text("Selecionar usuário")){
                        ForEach(userManager.filteredUsers){ user in
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                Text(user.email ?? "")
                                    
                            })
                            .foregroundStyle(Color(.black))
                        }
                    }.onAppear{
                        userManager.isSearchingUser = false
                    }
                }
                
            }
            
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .padding(-5)
        }
    }
    
}

#Preview {
    ListUsers()
}
