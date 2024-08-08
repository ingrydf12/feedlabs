//
//  Invite.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 31/07/24.
//

import Foundation

enum Status: String {
    case cancelado = "Cancelado"
    case enviado = "Enviado"
    case pendente = "Pendente"
    case aceito = "Aceito"
    case recusado = "Recusado"
}
struct Invite: Identifiable {
    var id: String
    var eventId: String?
    var from: String?
    var to: String?
    var status: Status?
    
    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.eventId = dictionary["for"] as? String
        self.from = dictionary["from"] as? String
        self.to = dictionary["to"] as? String
        if let statusString = dictionary["status"] as? String {
            self.status = Status(rawValue: statusString)
        }
    }
}
