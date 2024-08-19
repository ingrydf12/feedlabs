//
//  AddEventViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 12/08/24.
//

import Foundation

class AddEventViewModel: ObservableObject {
    
    @Published var name: String = ""
    var isPrivate: Bool = true
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var type: EventType = .meet
    @Published var selectedParticipants: Set<String> = []
    
    var userId = AuthManager.shared.userId ?? ""
    
    private func createEventInDatabase() -> String? {
        
        var participants = [userId]
        
        switch type {
        case .talk:
            isPrivate = false
        case .teamMeet:
            participants.append(contentsOf: Array(selectedParticipants))
        case .particular:
             isPrivate = false
        default:
            isPrivate = true
        }
        
        let newEvent = Event(
            isPrivate: isPrivate,
            participants: participants,
            owners: [userId],
            name: name,
            description: description,
            createdAt: Date(),
            date: date, type: type
        )
        
        return EventManager.shared.addEvent(newEvent)
    }
    func inviteParticipants() {
        guard let eventId = createEventInDatabase() else { // Cria o evento no banco de dados e obtém o ID
            print("Failed to create event")
            return
        }
        
        switch type {
        case .talk, .teamMeet, .particular:
            return
        case .meet, .oneOnOne:
            break
        }
        
        print("convidando")
        // Envia convites para os participantes selecionados
        for participantId in selectedParticipants {
            InviteManager.shared.createInvite(for: eventId, to: participantId)
        }
    }

}
