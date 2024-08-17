//
//  ChatMessage.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 31/07/24.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: Codable, Identifiable {
    @DocumentID var id: String?
    var text: String?
    var toUser: String?
    var fromUser: String?
    var chatId: String?
    var timestamp: Timestamp?
}
