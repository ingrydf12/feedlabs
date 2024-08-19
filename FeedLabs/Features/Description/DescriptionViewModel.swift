//
//  DescriptionViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 13/08/24.
//

import Foundation

@Observable
class DescriptionViewModel {
    
    var teamManager = TeamsManager()
    var user = UserManager.shared.user
    var teamId: String = ""
    var meet: Event?
    var team: Team?
    var name: String = ""
    var description: String = ""
    var participants: [String] = []
    var owners: [String] = []
    var type: EventType?
    var createdAt: Date?
    var date: Date?
    var doneAt: Date?
    var userCanEdit: Bool = false
    
    var isMeetDescription: Bool {
            return meet != nil
        }
    
    init(meet: Event){
        print("initing event description view model")
        self.meet = meet
        self.name = meet.name ?? ""
        self.description = meet.description ?? ""
        self.participants = meet.participants
        self.owners = meet.owners
        self.createdAt = meet.createdAt
        self.doneAt = meet.doneAt
        self.type = meet.type
        if meet.owners.contains(user?.id ?? ""){
            self.userCanEdit = true
        }
    }
    
    init(team: Team){
        print("initing teams description view model")
        self.team = team
        self.name = team.name
        self.description = team.description ?? ""
        self.participants = team.participants ?? []
        self.teamId = team.id ?? ""
        
        if user?.role == .mentor {
            self.userCanEdit = true
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Formato para horas e minutos
        return formatter
    }()
    
    func deleteMeet(){
        if let eventId = meet?.id {
            EventManager.shared.deleteEvent(eventId)
        }
    }
}
