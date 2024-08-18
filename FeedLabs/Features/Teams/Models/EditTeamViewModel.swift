//
//  NewTeamViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 09/08/24.
//

import Foundation

class EditViewModel: ObservableObject {
    
    var teamManager = TeamsManager()
    var teamId: String = ""
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var participants: [String] = []
    @Published var owners: [String] = []
    @Published var selectedParticipants: Set<String> = []
    @Published var type: EventType = .meet
    @Published var users: [User] = []
    
    init(){
        print("initing new teams view model")
        self.users = UserManager.shared.filteredUsers
    }
    
    init(team: Team){
        print("initing editing teams view model")
        self.users = UserManager.shared.filteredUsers
        self.name = team.name
        self.description = team.description ?? ""
        self.selectedParticipants = Set(team.participants ?? [])
        self.teamId = team.id ?? ""
    }
    
    func createTeam(){
        
        guard let userId = AuthManager.shared.userId else { return }
        participants.append(userId)
        
        let newTeam = Team(
            name: name,
            description: description,
            participants: Array(selectedParticipants),
            owners: [userId],  // Presumindo que o criador do time é o dono
            events: []
        )
        
        teamManager.createTeam(newTeam){ success in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("TeamsUpdated"), object: nil)
                print("ok")
            }else {
                print("ok nao")
            }
        }
    }
    func editTeam() {
        
        let updatedTeam = Team (
            id: teamId,
            name: name,
            description: description,
            participants: Array(selectedParticipants)
        )
        
        teamManager.updateTeam(updatedTeam) { success in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("TeamsUpdated"), object: nil)
                print("Team updated successfully")
            } else {
                print("Failed to update team")
            }
        }
    }
    func deleteTeam(){
        teamManager.deleteTeam(teamId) { success in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("TeamsUpdated"), object: nil)
                print("Team deleated successfully")
            } else {
                print("Failed to update team")
            }
        }
    }

    
}
