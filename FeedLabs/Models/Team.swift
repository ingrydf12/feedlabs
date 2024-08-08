//
//  Team.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import Foundation
import FirebaseFirestore

struct Team: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    var participants: [String]?
    var owners: [String]?
    var events: [String]?
}
