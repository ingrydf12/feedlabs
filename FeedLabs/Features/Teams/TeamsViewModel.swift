//
//  TeamsViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import Foundation

enum TeamStatus: String {
    case limite = "No limite"
    case prazo = "No prazo"
}

class TeamsViewModel: ObservableObject {
    
    var teamManager = TeamsManager()

    @Published var teams: [Team] = []
    @Published var teamMeets: [Event] = []
    @Published var role: Role?
    
    init(){
        print("Initializing TeamsViewModel")
        NotificationCenter.default.addObserver(self, selector: #selector(configureTeamsBasedOnUserRole), name: NSNotification.Name("UserUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getTeamMeets), name: NSNotification.Name("EventsUpdated"), object: nil)
    }
    
    @objc func configureTeamsBasedOnUserRole() {
        role = UserManager.shared.user?.role
        switch role {
        case .mentor:
            getAllTeams()
        case .student:
            getUserTeams()
        default:
            getAllTeams()
        }
    }
    
    func getAllTeams(){
        print("getting all teams")
        teamManager.getAllTeams{ teams in
            if let teams = teams {
                self.teams = teams
            }
        }
    }
    func getUserTeams(){
        print("getting user teams")
        teamManager.getUserTeams{ teams in
            if let teams = teams {
                self.teams = teams
            }
        }
    }
    
    @objc func getTeamMeets() {
        let allEvents = EventManager.shared.events
        self.teamMeets = allEvents.filter { event in
            return event.type == .teamMeet
        }
    }
}
