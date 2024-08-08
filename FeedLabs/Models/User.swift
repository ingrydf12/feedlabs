//
//  User.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable,Identifiable {
    @DocumentID var id: String?
    var name: String?
    var email: String?
    var role: Role?
}

enum Role: String, Codable {
    case mentor = "Mentor"
    case admin = "Admin"
    case student = "Residente"
}
