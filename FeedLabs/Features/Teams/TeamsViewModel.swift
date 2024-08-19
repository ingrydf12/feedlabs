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

//@Observable class

@Observable // improve performance
final class TeamsViewModel {
    
    static let shared = TeamsViewModel() // Global instance
    
    var teamManager = TeamsManager()

    var teams: [Team] = []
    var teamMeets: [Event] = []
    var role: Role?
    
    private init(){
        print("Initializing TeamsViewModel")
        NotificationCenter.default.addObserver(self, selector: #selector(configureTeamsBasedOnUserRole), name: NSNotification.Name("UserUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getTeamMeets), name: NSNotification.Name("EventsUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(configureTeamsBasedOnUserRole), name: NSNotification.Name("TeamsUpdated"), object: nil)
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
        print("getting tm")
        let allEvents = EventManager.shared.events
        self.teamMeets = allEvents.filter { event in
            return event.type == .teamMeet
        }
    }
}
