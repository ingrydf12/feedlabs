//
//  TeamsManager.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 07/08/24.
//

import Foundation
import FirebaseFirestore

class TeamsManager {
    
    private let db = Firestore.firestore()
    private let collection = "Teams"
    
    func getUserTeams(completion: @escaping ([Team]?) -> Void) {
        guard let userId = AuthManager.shared.userId else {
            completion(nil)
            return
        }
        
        db.collection(collection)
            .whereField("participants", arrayContains: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching user teams: \(error)")
                    completion(nil)
                } else {
                    let teams = snapshot?.documents.compactMap { document -> Team? in
                        return try? document.data(as: Team.self)
                    }
                    completion(teams)
                }
            }
    }

    
    func getAllTeams(completion: @escaping ([Team]?) -> Void) {
        db.collection(collection)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching all teams: \(error)")
                    completion(nil)
                } else {
                    let teams = snapshot?.documents.compactMap { document -> Team? in
                        return try? document.data(as: Team.self)
                    }
                    completion(teams)
                }
            }
    }
    
    func createTeam(_ team: Team, completion: @escaping (Bool) -> Void) {
        do {
            let newTeamRef = db.collection(collection).document()
            var team = team
            team.id = newTeamRef.documentID
            try newTeamRef.setData(from: team) { error in
                if let error = error {
                    print("Error creating team: \(error)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } catch {
            print("Error encoding team: \(error)")
            completion(false)
        }
    }
    func updateTeam(_ team: Team, completion: @escaping (Bool) -> Void) {
        guard let teamId = team.id else {
            print("Error: Team ID is missing")
            completion(false)
            return
        }
        
        let teamRef = db.collection(collection).document(teamId)
        var updateData: [String: Any] = [:]
        
        updateData["name"] = team.name
        
        if let description = team.description {
            updateData["description"] = description
        }
        if let participants = team.participants {
            updateData["participants"] = participants
        }
        if let owners = team.owners {
            updateData["owners"] = owners
        }

        teamRef.updateData(updateData) { error in
            if let error = error {
                print("Error updating team: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func addParticipant(_ userId: String, to teamID: String, completion: @escaping (Bool) -> Void) {
        let teamRef = db.collection(collection).document(teamID)
        
        teamRef.updateData([
            "participants": FieldValue.arrayUnion([userId])
        ]) { error in
            if let error = error {
                print("Error adding participant: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func removeParticipant(_ userId: String, from teamID: String, completion: @escaping (Bool) -> Void) {
        let teamRef = db.collection(collection).document(teamID)
        
        teamRef.updateData([
            "participants": FieldValue.arrayRemove([userId])
        ]) { error in
            if let error = error {
                print("Error removing participant: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    func deleteTeam(_ teamID: String, completion: @escaping (Bool) -> Void) {
        let teamRef = db.collection(collection).document(teamID)
        
        teamRef.delete { error in
            if let error = error {
                print("Error deleting team: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
