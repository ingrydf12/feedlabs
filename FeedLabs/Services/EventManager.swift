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
        getEvents()
    }
    
    func getEvents() {
        guard let userId = AuthManager.shared.userId else {
            print("User is not authenticated")
            return
        }
        
        print("Fetching all events for user id: \(userId)")
        
        let db = Firestore.firestore()
        let ref = db.collection("Events")
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events:", error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self.events = snapshot.documents.compactMap { document in
                    try? document.data(as: Event.self)
                }
                print("Events fetched successfully")
            }
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
