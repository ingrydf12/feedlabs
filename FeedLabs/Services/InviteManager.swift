//
//  InviteManager.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 31/07/24.
//

//criar e enviar, aceitar, recusar, buscar.
import Foundation
import Firebase
import FirebaseDatabaseInternal

@Observable
class InviteManager {
    
    static let shared = InviteManager()
    
    var invites: [Invite] = []
    var pendingInvitesCount: Int = 0

    private var invitesRef: DatabaseReference?
    private var invitesHandle: DatabaseHandle? // Observador
    
    private init() {
        print("initing invite manager")
        self.observeInvites()
    }
    
    deinit {
        print("saindo")
        self.removeObserver()
    }
    
    private func observeInvites() {
        
        guard let userId = AuthManager.shared.userId else { return }
        
        print("observing invites")
        self.invitesRef = Database.database().reference().child("users").child(userId).child("invites")
        
        self.invitesHandle = invitesRef?.observe(.childAdded, with: { [weak self] snapshot in
            let inviteId = snapshot.key
            
            let inviteDetailRef = Database.database().reference().child("invites").child(inviteId)
            inviteDetailRef.observe(.value, with: { snapshot in
                if let inviteData = snapshot.value as? [String: Any],
                   let invite = Invite(id: inviteId, dictionary: inviteData) {
                    DispatchQueue.main.async {
                        if let index = self?.invites.firstIndex(where: { $0.id == inviteId }) {
                            self?.invites[index] = invite // Atualiza o convite existente
                        } else {
                            self?.invites.append(invite) // Adiciona um novo convite
                        }
                        self?.updatePendingInvitesCount() // Atualiza a contagem de convites pendentes
                    }
                }
            })
        })
        
        // Observando remoção de convites
        invitesRef?.observe(.childRemoved, with: { [weak self] snapshot in
            let inviteId = snapshot.key
            DispatchQueue.main.async {
                self?.invites.removeAll { $0.id == inviteId }
                self?.updatePendingInvitesCount() // Atualiza a contagem de convites pendentes

            }
        })
    }
    private func updatePendingInvitesCount() {
        let userId = AuthManager.shared.userId ?? ""
        let count = invites.filter { $0.status == .pendente && $0.to == userId }.count
        self.pendingInvitesCount = count
    }
    func removeObserver() {
        if let handle = self.invitesHandle {
            self.invitesRef?.removeObserver(withHandle: handle)
            self.invitesHandle = nil
        }
    }
    
    func createInvite(for eventId: String, to userId: String) {
        guard let from = AuthManager.shared.userId else {
            print("User ID is missing")
            return
        }
        
        let ref = Database.database().reference()
        let invitesRef = ref.child("invites")
        
        // Query to check if an invite already exists for this event and user
        invitesRef.queryOrdered(byChild: "for").queryEqual(toValue: eventId).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    if let inviteData = child.value as? [String: Any],
                       let inviteTo = inviteData["to"] as? String,
                       inviteTo == userId {
                        // An invite already exists for this event and user
                        print("Invite already exists for this event and user.")
                        return
                    }
                }
            }
            
            // No existing invite found, proceed to create a new invite
            let inviteId = invitesRef.childByAutoId().key
            
            let inviteData: [String: Any] = [
                "for": eventId,
                "from": from,
                "to": userId,
                "status": Status.pendente.rawValue
            ]
            
            guard let inviteId = inviteId else {
                print("Failed to generate invite ID")
                return
            }
            
            let updates = [
                "invites/\(inviteId)": inviteData,
                "users/\(from)/invites/\(inviteId)": true,
                "users/\(userId)/invites/\(inviteId)": true
            ] as [String : Any]
            
            ref.updateChildValues(updates) { error, _ in
                if let error = error {
                    print("Failed to create invite: \(error.localizedDescription)")
                } else {
                    print("Invite created successfully")
                }
            }
        }
    }

    
    func updateInviteStatus(_ invite: Invite, status: Status) {
        
        let ref = Database.database().reference()
        let inviteId = invite.id
        let eventId = invite.eventId ?? ""
        let userID = UserManager.shared.user?.id ?? ""
        
        switch status {
            case .aceito:
                EventManager.shared.addParticipant(userId: userID, to: eventId)
                ref.child("invites").child(inviteId).child("status").setValue(status.rawValue)
            case .cancelado:
                let from = invite.from ?? ""
                let toId = invite.to ?? ""
                
                ref.child("invites").child(inviteId).removeValue()
                ref.child("users").child(from).child("invites").child(inviteId).removeValue()
                ref.child("users").child(toId).child("invites").child(inviteId).removeValue()
            
            default: // pendente e enviado
                ref.child("invites").child(inviteId).child("status").setValue(status.rawValue)
        }
        updatePendingInvitesCount()
    }
    func resetInvitesData() {
        DispatchQueue.main.async {
            self.invites = []
            self.pendingInvitesCount = 0
        }
    }
    
    func handleLogout() {
        print("saindo do observador")
        removeObserver() // Remove Firebase observers
        resetInvitesData() // Clear invites and pending count
    }
    func getEventById(eventId: String) -> String? {
        return EventManager.shared.events.first(where: { $0.id == eventId })?.name
    }
}
