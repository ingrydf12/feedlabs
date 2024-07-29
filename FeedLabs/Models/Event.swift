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
    var name: String?
    var description: String?
    var createdAt: Date?
    var date: Date?
    var doneAt: Date?
    var estimatedTime: Int?
    var participants: [String]?
    var owners: [String]?
}
