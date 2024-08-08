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
    @Published private var userManager = UserManager.shared {
        didSet {
            if let role = userManager.user?.role {
                configureTeamsBasedOnUserRole(role: role)
            }
        }
    }
    @Published var teams: [Team] = []
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var participants: [String] = []
    @Published var owners: [String] = []
    
    init(){
        print("Initializing TeamsViewModel")
        userManager.userDidUpdate = { [weak self] in
            guard let self = self, let role = self.userManager.user?.role else { return }
            self.configureTeamsBasedOnUserRole(role: role)
        }
        if let role = userManager.user?.role {
            configureTeamsBasedOnUserRole(role: role)
        }
    }
    
    private func configureTeamsBasedOnUserRole(role: String) {
        switch role {
        case "Mentor":
            getAllTeams()
        case "Student":
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
    func createTeam(){
        
        guard let userId = AuthManager.shared.userId else { return }
        
        let newTeam = Team(
            name: name,
            description: description,
            participants: participants,
            owners: [userId],  // Presumindo que o criador do time é o dono
            events: []
        )
        
        teamManager.createTeam(newTeam){ success in
            if success {
                print("ok")
            }else {
                print("ok nao")
            }
        }
    }
}
