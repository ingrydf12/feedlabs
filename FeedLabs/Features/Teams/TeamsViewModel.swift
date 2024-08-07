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
    
    let teamManager = TeamsManager()
    
    @Published var teams: [Team] = []
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var participants: [String] = []
    @Published var owners: [String] = []

    func getAllTeams(){
        print("getting all teams")
        teamManager.getAllTeams{ teams in
            if let teams = teams {
                self.teams = teams
            }
        }
    }
    func getUserTeams(){
        teamManager.getUserTeams{ teams in
            if let teams = teams {
                self.teams = teams
            }
        }
        print(teams)
    }
    func createTeam(){
        
        guard let userId = AuthManager.shared.userId else { return }
        
        let newTeam = Team(
            name: name,
            description: description,
            participants: [userId],
            owners: [userId],
            events: []
        )
        
        teamManager.createTeam(newTeam){ success in
            if success {
                print("ok")
            }else {
                print("ok nao")
            }
        }
        
        getAllTeams()
    }
    
    // se for student pega o seu, se for mentor pega todos
    
    // get participantes by id
    
    
}
