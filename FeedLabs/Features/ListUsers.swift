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
    @StateObject var userManager = UserManager.shared
    @State private var isPrivate: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Selecionar usuário")){
                    List(filterUsers(users: userManager.users)){ user in
                        HStack{
                            Text(user.email ?? "")
                        }
                    }
                }
            }
            .navigationTitle("List Users")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func filterUsers(users: [User]) -> [User]{
        let userFilter = users.filter({
            return $0.id != AuthManager.shared.userId
        })
        return userFilter
    }
}

#Preview {
    ListUsers()
}
