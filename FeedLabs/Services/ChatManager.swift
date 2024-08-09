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
    
    func getChats(){
        print("getting chats")
        guard let userId = AuthManager.shared.userId else {return}
        
        let db = Firestore.firestore()
        let ref = db.collection("Chats")
        
        ref.getDocuments{snapshot, error in
            if let error = error {
                print("error:", error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                self.chats = snapshot.documents.compactMap{ document in
                    try? document.data(as: ChatUser.self)
                }
                
                print("Chats fetched successfully")
            }
        }
    }
    
    func getChatsByUser(_ userId: String) -> [ChatUser]{
        print("getting chats by user")
        guard let userId = AuthManager.shared.userId else {return []}
        
        return chats?.filter{return $0.userId == userId } ?? []
        
    }
    
    func addChat(chat: ChatUser){
        guard let chatId = chat.id else {
            print("Chat ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        do{
            try
            db.collection("Chats").document(chatId)
                .setData(from: chat){ error in
                    if let error = error {
                        print("Error adding chat to Firestore: \(error.localizedDescription)")
                    }else{
                        print("Chats added successfully to Firestore")
                        let ref = Database.database().reference()
                        ref.child("chats/\(chatId)").setValue(["exists": true]){ error, _ in
                            if let error = error{
                                print("Error adding chat ID to Realtime Database: \(error.localizedDescription)")
                            }else {
                                print("User ID added successfully to Realtime Database")
                            }
                        }
                    }
                }
        }catch let error {
            print("Error adding user to Firestore: \(error.localizedDescription)")
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
