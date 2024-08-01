//
//  ChatManager.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 31/07/24.
//

import Foundation

class ChatManager: ObservableObject{
    
    static let shared = ChatManager()
    
    @Published var chats: [ChatUser]?
    
    func getChats(){
        //self.shared
    }
}
