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
    case meet = "Meet"
    case talk = "Talk"
    case oneOnOne = "One a One"
    case teamMeet = "Team Meet"
    case particular = "Particular"
}
