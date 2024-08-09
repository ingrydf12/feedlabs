//
//  MessageManager.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 09/08/24.
//

import Foundation


class MessageManager: ObservableObject{
    
    static let shared = MessageManager()
    
    @Published private var messages: [ChatMessage]?
    
    func getMessages(){
        
    }
}

