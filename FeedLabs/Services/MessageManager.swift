//
//  MessageManager.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 09/08/24.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

class MessageManager: ObservableObject{
    
    static let shared = MessageManager()
    
    @Published private var messages: [ChatMessage]?
    @Published var filteredMessages: [ChatMessage] = []
    @Published var messageAddId: String?
    var chatId: String?{
        didSet{
            self.getChatMessages(chatId: chatId ?? "")
        }
    }
    
    init(){
        getMessages()
    }
    
    func getMessages(){
        print("getting messages")
        
        guard let userId = AuthManager.shared.userId else {return}
        
        let db = Firestore.firestore()
        let ref = db.collection("ChatMessages")
        
        ref.order(by: "timestamp").addSnapshotListener{ snapshot, error in
            if let error = error {
                print("error", error.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                snapshot.documentChanges.forEach{ change in
                    if change.type == .added{
                        let data = try? change.document.data(as: ChatMessage.self)
                        self.messages?.append(data ?? ChatMessage())
                    }
                }
                self.messages = snapshot.documents.compactMap{
                    document in
                    try? document.data(as: ChatMessage.self)
                }
                if let chatId = self.chatId {
                    self.getChatMessages(chatId: chatId)
                }
            }
        }
    }
    
    func getChatMessages(chatId: String){
        self.filteredMessages.removeAll()
        self.filteredMessages = self.messages?.filter{return $0.chatId == chatId} ?? []
        //print(self.filteredMessages)
    }
    
    func addMessage(message: ChatMessage, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let docRef = db.collection("ChatMessages").document()
        
        do{
            try docRef.setData(from: message){
                error in
                if let error = error{
                    print("Error adding message to Firestore: \(error.localizedDescription)")
                    completion(false)
                }else{
                    print("Message added successfully to Firestore")
                    self.messageAddId = docRef.documentID
                    self.getMessages()
                    completion(true)
                }
            }
        }catch let error {
            print("Error adding message to Firestore: \(error.localizedDescription)")
        }
        
    }
    
    func getMessageById(_ messageId: String) -> ChatMessage{
        if messageId == "" {
            print("Message ID is missing")
            return ChatMessage()
        }
        
        return messages?.filter{return $0.id == messageId }.first ?? ChatMessage()
    }
    
    func deleteMessage(_ messageId: String){
        let firestore = Firestore.firestore()
    
        firestore.collection("ChatMessages").document(messageId).delete{
            error in
            if let error = error{
                print("Error deleting message: \(error.localizedDescription)")
            }else{
                self.getMessages()
            }
        }
        
    }
}

