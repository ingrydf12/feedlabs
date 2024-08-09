import Foundation
import FirebaseFirestore

class EventManager: ObservableObject {
    
    static let shared = EventManager()
    
    @Published var events: [Event] = []
    
    private init() {
        print("init Event Manager")
        getEvents()
    }
    
    func getEvents() {
        guard let userId = AuthManager.shared.userId else {
            print("User is not authenticated")
            return
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Events")
        
        ref.getDocuments { snapshot, error in
            DispatchQueue.global(qos: .userInitiated).async {
                if let error = error {
                    print("Error fetching events:", error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    let fetchedEvents = snapshot.documents.compactMap { document in
                        do {
                            let event = try document.data(as: Event.self)
                            return self.haveAcess(of: userId, to: event) ? event : nil
                        } catch {
                            return nil
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.events = fetchedEvents
                        NotificationCenter.default.post(name: NSNotification.Name("EventsUpdated"), object: nil)
                        print("Events fetched successfully")
                    }
                }
            }
        }
    }
    
    private func haveAcess(of user: String, to event: Event) -> Bool {
        if event.isPrivate {
            return event.participants.contains(user) || event.owners.contains(user)
        } else {
            return true
        }
    }
    
    func addEvent(_ event: Event) {
        let db = Firestore.firestore()
        do {
            try db.collection("Events").addDocument(from: event) { error in
                DispatchQueue.global(qos: .userInitiated).async {
                    if let error = error {
                        print("Error adding event: \(error.localizedDescription)")
                        return
                    } else {
                        DispatchQueue.main.async {
                            self.getEvents()
                        }
                    }
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
            DispatchQueue.global(qos: .userInitiated).async {
                if let error = error {
                    print("Error adding participant: \(error.localizedDescription)")
                    return
                } else {
                    DispatchQueue.main.async {
                        print("Participant added successfully")
                        self.getEvents() // Atualiza os eventos após adicionar o participante
                    }
                }
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
                DispatchQueue.global(qos: .userInitiated).async {
                    if let error = error {
                        print("Error updating event: \(error.localizedDescription)")
                        return
                    } else {
                        DispatchQueue.main.async {
                            self.getEvents()
                        }
                    }
                }
            }
        } catch let error {
            print("Error updating event in Firestore: \(error.localizedDescription)")
        }
    }
    
    func deleteEvent(_ eventId: String) {
        let db = Firestore.firestore()
        
        db.collection("Events").document(eventId).delete { error in
            DispatchQueue.global(qos: .userInitiated).async {
                if let error = error {
                    print("Error deleting event: \(error.localizedDescription)")
                    return
                } else {
                    DispatchQueue.main.async {
                        self.getEvents()
                    }
                }
            }
        }
    }
}
