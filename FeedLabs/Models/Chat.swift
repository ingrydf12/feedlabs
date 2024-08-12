//
//  Chat.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 31/07/24.
//

import Foundation
import FirebaseFirestore

struct ChatUser: Identifiable{
    var id: String?
    //var messages: [ChatMessage]?
    var email: String?
    
    init(user: User){
        self.id = user.id
        //self.messages = []
        self.email = user.email
    }
}

