//
//  InviteParticipantsViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 18/08/24.
//
import Foundation

class InviteMemberViewModel: ObservableObject {
    
    var event: Event
    
    @Published var searchItem: String = "" {
        didSet {
            filterUsers()
        }
    }
    
    @Published var userManager = UserManager.shared
    @Published var inviteManager = InviteManager.shared
    @Published var filteredUsers: [User] = []
    
    init(toMeet meet: Event) {
        self.event = meet
        filterUsers()
    }
    
    private func filterUsers() {
        if searchItem.isEmpty {
            // Filter out users who are already participants of the event
            filteredUsers = userManager.users.filter { user in
                guard let userId = user.id else { return false }
                return !event.participants.contains(userId)
            }
        } else {
            // Apply search filter and exclude participants
            filteredUsers = userManager.users.filter { user in
                guard let userId = user.id else { return false }
                let isNotParticipant = !event.participants.contains(userId)
                let matchesSearch = user.name?.localizedStandardContains(searchItem) ?? false
                return isNotParticipant && matchesSearch
            }
        }
    }
}

