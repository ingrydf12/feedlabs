//
//  AddEventViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 12/08/24.
//

import Foundation

class AddEventViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var isPrivate: Bool = false
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var type: EventType = .meet
    @Published var selectedParticipants: Set<String> = []
    
    var userId = AuthManager.shared.userId ?? ""
    
    func createEvent(){
        
        let newEvent = Event(
            isPrivate: isPrivate,
            participants: Array(selectedParticipants) + [userId],
            owners: [userId],
            name: name,
            description: description,
            createdAt: Date(),
            date: date, type: type
        )
        
        EventManager.shared.addEvent(newEvent)
    }
    func inviteParticipants(){
        
    }
}
