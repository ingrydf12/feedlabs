//
//  ChatsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct ChatsView: View {
    @State var user: User?
    @State var message: String = ""
    @State var chatUser: ChatUser?
    @State var isEdit: Bool = false
    @StateObject var messageManager = MessageManager.shared
    @Environment(\.presentationMode) var presentationMode

    init(user: User, chat: ChatUser? = nil){
        _user = State(initialValue: user)
        if chat != nil {
            _chatUser = State(initialValue: chat)
            _isEdit = State(initialValue: true)
            
        }else if chatUser?.id == nil{
            _chatUser = State(initialValue:  ChatUser(messages: [], fromUser: AuthManager.shared.userId, toUser: user.id))
            _isEdit = State(initialValue: false)
        }
        
    }
    
    var body: some View {
       
        NavigationStack{
            VStack{
                ScrollView{
                    VStack(alignment: .trailing){
                        VStack{
                            ForEach(messageManager.filteredMessages){ message in
                                HStack{
                                    Spacer()
                                    HStack{
                                        if AuthManager.shared.userId == message.fromUser {Spacer()}
                                        Text(message.text ?? "")
                                            .frame(alignment: .trailing)
                                            .padding()
                                            .background(Color(.white))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color("darkAqua"), lineWidth: 2)
                                            )
                                        if AuthManager.shared.userId != message.fromUser {Spacer()}
                                    }
                                }
                                
                            }
                        }
                    }.padding()
                }
                Spacer()
                VStack{
                    HStack{
                        HStack{
                            TextField( "Insira uma mensagem", text: $message)
                                .padding()
                                .font(.callout)
                                
                            Button(action: {
                             
                            }, label: {
                               Image(systemName: "paperclip")
                                   .foregroundColor(Color("darkAqua"))
                            }).padding()
                               
                                .cornerRadius(30)
                        }.background(Color(.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("darkAqua"), lineWidth: 2)
                        )
                        
                        Button(action: {
                            if message != "" {
                                let chatMessage = ChatMessage( text: message, toUser: user?.id, fromUser: AuthManager.shared.userId, chatId: self.chatUser?.id)
                                
                                self.message = ""
                                messageManager.addMessage(message: chatMessage){ success in
                                    if success{
                                        if let messageId = messageManager.messageAddId {
                                            self.chatUser?.messages?.append(messageId)
                                            ChatManager.shared.editChat(chat: self.chatUser ?? ChatUser())
                                            //print(self.chatUser ?? "")
                                        }else{
                                            print("Erro: messageAddId está nulo")
                                        }
                                    }
                                }
                            }
                        }
                        , label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color("darkAqua") )
                        })
                        .padding()
                        .background(Color("lightAqua"))
                        .cornerRadius(30)
                    }
                    .font(.title2)
                }.padding()
                .padding(.top)
                .background(Color("backgroudTextField"))
            
            }
            .navigationTitle(user?.name ?? "Lucas")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {presentationMode.wrappedValue.dismiss()}){
                      
                        Image(systemName: "chevron.backward").padding(-4)
                        Text("Voltar")
                    }.foregroundStyle(Color("darkAqua"))
                        .font(.headline)
                }
            }
            .toolbarBackground(Color("backgroudTextField"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
           
        }.navigationBarBackButtonHidden(true)
        .onAppear{
            if self.isEdit {
                self.chatUser = ChatManager.shared.getChatById(self.chatUser?.id ?? "")
            } else {
                if let chat = self.chatUser{
                    if chat.id == nil{
                        ChatManager.shared.addChat(chat: chat){ created in
                            if created{
                                if let chatId = ChatManager.shared.chatAddId{
                                    self.chatUser = ChatManager.shared.getChatById(chatId)
                                    messageManager.chatId = self.chatUser?.id
                                }
                            }
                        }
                    }
                }
            }
            messageManager.chatId = self.chatUser?.id
        }
    }
}


#Preview {
    ChatsView(user: User())
}
