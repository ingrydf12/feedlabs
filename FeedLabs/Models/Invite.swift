//
//  Invite.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 31/07/24.
//

import Foundation

struct Invite {
    let id: String?
    let eventId: String?
    let from: String?
    let to: String?
    var status: Status?
    
    enum Status: String {
        case cancelado = "Cancelado"
        case enviado = "Enviado"
        case pendente = "Pendente"
        case aceito = "Aceito"
    }
}
