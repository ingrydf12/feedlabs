//
//  ChatManager.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 31/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

class ChatManager: ObservableObject{
    
    static let shared = ChatManager()
    
    @Published private var chats: [ChatUser]?
    @Published var filteredChats: [ChatUser] = []
    //@Published var chatsWithMe: [ChatUser] = []
    @Published var filteredUsersByChats: [User] = []
    @Published var filteredUsersByName: [User] = []
    @Published var searchText: String = ""
    @Published var chatAddId: String?
    @Published var isSearchingUser: Bool = false{
        didSet {
            if self.searchText.count != 0 {
                self.filterUserByName( name: searchText)
            }else {
                self.filteredUsersByName.removeAll()
            }
        }
    }
    
    init() {
        getChats()
    }
    
    func getChats(){
        print("getting chats")
        guard let userId = AuthManager.shared.userId else {return}
        
        let db = Firestore.firestore()
        let ref = db.collection("Chats")
        
        ref.addSnapshotListener(){snapshot, error in
            if let error = error {
                print("error:", error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                //snapshot.documentChanges.com
                snapshot.documentChanges.forEach{ change in
                    if change.type == .added{
                        let data = try? change.document.data(as: ChatUser.self)
                        self.chats?.append(data ?? ChatUser())
                    }
                }
                self.chats = snapshot.documents.compactMap{ document in
                    try? document.data(as: ChatUser.self)
                }
                self.filteredChats = self.chats?.filter{return $0.fromUser == userId } ?? []
                self.filteredChats += self.checkInvertChats(chats: self.chats ?? [])
                self.getUserByChats()
                print("Chats fetched successfully")
                
            }
        }
    }
    
    func checkInvertChats(chats: [ChatUser]) -> [ChatUser]{
        var chatsWithMe: [ChatUser] = []
        for chat in chats{
            if chat.toUser == AuthManager.shared.userId {
                chatsWithMe.append(invertChatUsers(chatUser: chat))
            }
        }
        return chatsWithMe
    }
    
    func invertChatUsers(chatUser: ChatUser) -> ChatUser{
        return ChatUser(id: chatUser.id, messages: chatUser.messages, fromUser: chatUser.toUser, toUser: chatUser.fromUser)
    }
    
    func getChatsByUser(_ userId: String) -> [ChatUser]{
        print("getting chats by user")
        guard let userId = AuthManager.shared.userId else {return []}
        
        return chats?.filter{return $0.fromUser == userId } ?? []
        
    }
    
    func getUserByChats(){
        filteredUsersByChats.removeAll()
        for chat in filteredChats{
            if chat.toUser != nil {
                filteredUsersByChats.append(UserManager.shared.getUserById(chat.toUser ?? "") ?? User())
            }
        }
    }
    
    
    func filterUserByName(name: String){
        guard !searchText.isEmpty else {
            self.filteredUsersByName = []
            return
        }
        
        self.filteredUsersByName = self.filteredUsersByChats.filter{ return ($0.name ??  "").uppercased().contains(name.uppercased())}
    }
    
    func addChat(chat: ChatUser, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let docRef = db.collection("Chats").document()
        
        do{
            try
            docRef.setData(from: chat){ error in
                    if let error = error {
                        print("Error adding chat to Firestore: \(error.localizedDescription)")
                        completion(false)
                    }else{
                        print("Chat added successfully to Firestore")
                        self.chatAddId = docRef.documentID
                        print( self.chatAddId ?? "")
                        self.getChats()
                        completion(true)
                    }
                }
        }catch let error {
            print("Error adding chat to Firestore: \(error.localizedDescription)")
        }
        
    }
    
    func editChat(chat: ChatUser){
        guard let chatId = chat.id else {
            print("User ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        do{
            try
            db.collection("Chats").document(chatId)
                .setData(from: chat, merge: true)
            print("Chat edited successfully")
        } catch let error{
            print("Error editing chat: \(error.localizedDescription)")
        }
    }
    
    func getChatById(_ chatId: String) -> ChatUser{
        //getChats()
        if chatId == "" {
            print("Chat ID is missing")
            return ChatUser()
        }
        
        return chats?.filter{ return $0.id == chatId}.first ?? ChatUser()
    }
    
    func deleteChat(_ chatId: String){

        let firestore = Firestore.firestore()
        let realtimeDatabase = Database.database().reference()
        
        firestore.collection("Chats").document(chatId)
        .delete{ error in
            if let error = error {
                print("Error deleting chat from Firestore: \(error.localizedDescription)")
            } else{
                realtimeDatabase.child("chats/\(chatId)")
                .removeValue{ error, _ in
                    if let error = error {
                        print("Error deleting chat from Realtime Database: \(error.localizedDescription)")
                    }else{
                        print("Chat successfully deleted")
                    }
                }
            }
        }
    }
    
}
