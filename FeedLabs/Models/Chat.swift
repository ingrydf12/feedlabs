//
//  Chat.swift
//  FeedLabs
//
//  Created by Pedro Victor Furtado Sousa on 31/07/24.
//

import Foundation
import FirebaseFirestore

struct ChatUser: Codable, Identifiable {
    @DocumentID var id: String?
    var messages: [String]?
    var userId: String?
}

