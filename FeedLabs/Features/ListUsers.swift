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
    
    init(){
        fetchAllUsers()
    }
    
    func fetchAllUsers(){
        UserManager.shared.listUsers?.forEach({ user in
            let chatUser = ChatUser.init(user: user)
            if chatUser.id != AuthManager.shared.userId {
                self.users.append(chatUser)
            }
        })
    }
}

struct ListUsers: View {
    
    @ObservedObject var vm = CreatingNewMessageView()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Text(vm.erroMessage)
                ForEach(vm.users){ user in
                    
                    Text(user.email ?? "")
                }
            }
        }
    }
}

#Preview {
    ListUsers()
}
