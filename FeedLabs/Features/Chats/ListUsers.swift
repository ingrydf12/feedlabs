//
//  ListUsers.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 01/08/24.
//

import SwiftUI

struct ListUsers: View {
    @State var isSearching: Bool = false
    @StateObject var userManager = UserManager.shared
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
                            NavigationLink(destination: ChatsView(user: user)){
                                HStack{
                                    Image(systemName: "person.circle.fill")
                                        .font(.largeTitle)
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
                    }.onAppear{
                        userManager.isSearchingUser = false
                    }
                }
                
            }.toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        userManager.searchText = ""
                    }){
                      
                        Image(systemName:  "chevron.backward").padding(-4)
                        Text("Voltar")
                    }.foregroundStyle(Color("darkAqua"))
                        .font(.headline)
                        .padding(7)
                }
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}


#Preview {
    ListUsers()
}
