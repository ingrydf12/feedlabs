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

class InviteManager: ObservableObject {
    
    static let shared = InviteManager()
    
    @Published var invites: [Invite] = []
    
    private var invitesRef: DatabaseReference?
    private var invitesHandle: DatabaseHandle? // Observador
    
    init() {
        observeInvites()
    }
    
    deinit {
        if let invitesHandle = invitesHandle {
            invitesRef?.removeObserver(withHandle: invitesHandle)
        }
    }
    
    private func observeInvites() {
        guard let userId = AuthManager.shared.userId else {
            print("User ID is missing")
            return
        }
        
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
                    }
                }
            })
        })
        
        // Observando remoção de convites
        invitesRef?.observe(.childRemoved, with: { [weak self] snapshot in
            let inviteId = snapshot.key
            DispatchQueue.main.async {
                self?.invites.removeAll { $0.id == inviteId }
            }
        })
    }
    
    func createInvite(for eventId: String, to userId: String) {
        guard let from = AuthManager.shared.userId else {
            print("User ID is missing")
            return
        }
        
        let ref = Database.database().reference()
        let inviteId = ref.child("invites").childByAutoId().key
        
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
    }
}
