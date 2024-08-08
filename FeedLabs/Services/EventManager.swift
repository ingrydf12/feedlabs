//
//  EventManager.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore

class EventManager: ObservableObject {
    
    static let shared = EventManager()
    
    @Published var events: [Event]? = []
    
    private init () {
        print("init Event Manager")
    }
    
    func getEvents() {
        guard let userId = AuthManager.shared.userId else {
            print("User is not authenticated")
            return
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Events")
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events:", error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self.events = snapshot.documents.compactMap { document in
                    do {
                        let event = try document.data(as: Event.self)
                        if self.haveAcess(of: userId, to: event){
                            return event
                        }else{
                            return nil
                        }
                    } catch {
                        return nil
                    }
                }
                print("Events fetched successfully")
            }
        }
    }
    
    private func haveAcess(of user: String, to event: Event) -> Bool {
        if event.isPrivate {
            if event.participants.contains(user) || event.owners.contains(user){
                return true
            }else {
                return false
            }
        }else{
            return true
        }
    }
    
    func addEvent(_ event: Event) {
        let db = Firestore.firestore()
        do {
            let _ = try db.collection("Events").addDocument(from: event) { error in
                if let error = error {
                    print("Error adding event: \(error.localizedDescription)")
                } else {
                    self.getEvents()
                }
            }
        } catch let error {
            print("Error adding event to Firestore: \(error.localizedDescription)")
        }
    }
    
    func addParticipant(userId: String, to eventId: String) {
        let db = Firestore.firestore()
        let eventRef = db.collection("Events").document(eventId)
        
        eventRef.updateData([
            "participants": FieldValue.arrayUnion([userId])
        ]) { error in
            if let error = error {
                print("Error adding participant: \(error.localizedDescription)")
            } else {
                print("Participant added successfully")
                self.getEvents() // Atualiza os eventos após adicionar o participante
            }
        }
    }

    func updateEvent(_ event: Event) {
        guard let eventId = event.id else {
            print("Event ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        do {
            try db.collection("Events").document(eventId).setData(from: event, merge: true) { error in
                if let error = error {
                    print("Error updating event: \(error.localizedDescription)")
                } else {
                    self.getEvents()
                }
            }
        } catch let error {
            print("Error updating event in Firestore: \(error.localizedDescription)")
        }
    }
    
    func deleteEvent(_ eventId: String) {
        let db = Firestore.firestore()
        
        db.collection("Events").document(eventId).delete { error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            } else {
                self.getEvents() 
            }
        }
    }
}
