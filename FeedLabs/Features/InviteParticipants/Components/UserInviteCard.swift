// UserInviteCard.swift
// FeedLabs
// Created by Ingryd Cordeiro Duarte on 13/08/24.
//

import SwiftUI

struct UserInviteCard: View {
    var user: User
    var event: EventType  // Accepts EventType directly
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    @State private var selectedParticipants: Set<String> = []
    
    var body: some View {
        HStack(alignment: .center) {
            // Profile Image
            profileImageView
                .padding(15)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name ?? "sem nome")
                    .font(.tahoma(.bold, size: 24))
                
                // Role Tag
                roleTag
            }
            
            Spacer()
            
            // Invite Button
            HStack(alignment: .center){
                inviteButton(imageName: "person.fill.badge.plus", action: addUserToEvent)
                    .padding(10)
            }
        }
        .padding(5)
        .frame(maxWidth: 350)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(style: StrokeStyle(lineWidth: 2.0))
                .foregroundStyle(Color.accentColor)
        )
    }
    
    // Button with action
    private func inviteButton(imageName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
        }
    }
    
    // Handle the action to add user to event
    private func addUserToEvent() {
        guard let userId = user.id else { return }
        // Create the invite using the event's raw value
        inviteManager.createInvite(for: event.rawValue, to: userId)
        // Optionally update the UI to reflect that the user has been invited
        selectedParticipants.insert(userId)
    }
    
    // Profile Image View
    private var profileImageView: some View {
        ZStack {
            Circle()
                .fill(Color.purple)
                .frame(width: 60, height: 60)
            if let usernameInitial = user.name?.first {
                Text(String(usernameInitial))
                    .font(.tahoma(.primaryButton))
                    .foregroundStyle(Color.white)
            }
        }
    }
    
    // Role Tag
    private var roleTag: some View {
        HStack {
            if let userRole = user.role {
                Text(userRole.rawValue)
                    .font(.tahoma(.regular, size: 14))
                    .foregroundStyle(Color.black)
                    .padding(5)
                    .multilineTextAlignment(.center)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
        }
    }
}
