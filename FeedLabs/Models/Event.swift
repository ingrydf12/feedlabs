//
//  Event.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore

struct Event: Codable,Identifiable {
    @DocumentID var id: String?
    var isPrivate: Bool
    var participants: [String]
    var owners: [String]
    var name: String?
    var description: String?
    var createdAt: Date?
    var date: Date?
    var doneAt: Date?
    var estimatedTime: Int?
    var type: EventType
    
}

enum EventType: String, Codable, CaseIterable {
    case meet = "Meet (Privada)"
    case talk = "Talk (Pública)"
    case oneOnOne = "One a One (Privado)"
    case teamMeet = "Team Meet (Privado)"
    case particular = "Particular (Público)"
}
