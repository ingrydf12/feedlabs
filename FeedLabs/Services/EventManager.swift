import Foundation
import FirebaseFirestore

@Observable
class EventManager {
    
    static let shared = EventManager()
    
    var events: [Event] = []
    
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
    
    func addEvent(_ event: Event) -> String? {
        print("adicionando evento")
        let db = Firestore.firestore()
        let documentId = db.collection("Events").document().documentID // Gerar o ID do documento

        var eventWithId = event
        eventWithId.id = documentId // Atribuir o ID gerado ao evento
        
        do {
            try db.collection("Events").document(documentId).setData(from: eventWithId) { error in
                DispatchQueue.global(qos: .userInitiated).async {
                    if let error = error {
                        print("Error adding event: \(error.localizedDescription)")
                        return
                    } else {
                        DispatchQueue.main.async {
                            self.getEvents()
                            print("evento adicionado")
                        }
                    }
                }
            }
            return documentId // Retornar o ID do documento criado
        } catch let error {
            print("Error adding event to Firestore: \(error.localizedDescription)")
            return nil
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
