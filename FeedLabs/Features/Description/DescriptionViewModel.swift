//
//  DescriptionViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 13/08/24.
//

import Foundation

class DescriptionViewModel: ObservableObject {
    
    var teamManager = TeamsManager()
    var user = UserManager.shared.user
    var teamId: String = ""
    var meet: Event?
    var team: Team?
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var participants: [String] = []
    @Published var owners: [String] = []
    @Published var type: EventType?
    @Published var createdAt: Date?
    @Published var date: Date?
    @Published var doneAt: Date?
    @Published var userCanEdit: Bool = false
    
    init(meet: Event){
        print("initing event description view model")
        self.meet = meet
        self.name = meet.name ?? ""
        self.description = meet.description ?? ""
        self.participants = meet.participants
        self.owners = meet.owners
        self.createdAt = meet.createdAt
        self.date = meet.date
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
