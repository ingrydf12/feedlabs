//
//  LeaveEventViewModel.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 16/08/24.
//

import Foundation
import SwiftUI

class LeaveEventViewModel: ObservableObject {
    @Published var showPopup = false
    
    var eventManager = EventManager.shared
    
    var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    func leaveEvent() {
        guard let userId = AuthManager.shared.userId, let eventId = event.id else { return }
        
        eventManager.removeParticipant(userId, from: eventId) { success in
            if success {
                print("Successfully removed participant.")
            } else {
                print("Failed to remove participant.")
            }
            
            DispatchQueue.main.async {
                self.showPopup = false
            }
        }
    }
}
