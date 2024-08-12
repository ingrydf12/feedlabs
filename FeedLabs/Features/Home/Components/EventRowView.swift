//
//  EventRowView.swift
//  FeedLabs
//
//  Created by User on 12/08/24.
//

import SwiftUI

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        EventCard(showingInviteModal: .constant(false), selectedEvent: .constant(event.type.rawValue), user: event.owners.first!)
    }
}
