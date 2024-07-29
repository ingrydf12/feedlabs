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
    var role: String?
}
