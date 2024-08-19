// UserInviteCard.swift
// FeedLabs
// Created by Ingryd Cordeiro Duarte on 13/08/24.

import SwiftUI

struct UserInviteCard: View {
    var user: User
    var event: Event
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    @State private var selectedParticipants: Set<String> = []
    
    var body: some View {
        HStack(alignment: .center) {
            // Profile Image
            profileImageView // Perfil
                .padding(15)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name ?? "No name")
                    .font(.tahoma(.bold, size: 24))
                
                // Role Tag
                roleTag
            }
            
            Spacer()
            
            // Invite Button
            Button {
                addUserToEvent()
            } label: {
                Image(systemName: "person.fill.badge.plus")
                    .padding(10)
            }
            .buttonStyle(InviteButton())
            //.accessibility(label: "Botão para adicionar pessoa no evento")
        }
        .padding(5)
        .frame(maxWidth: 350)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color.accentColor, lineWidth: 2.0)
        )
    }
    
    //MARK: - addUserToEvent function
    // Handle the action to add user to event
    private func addUserToEvent() {
        guard let userId = user.id else { return }
        
        guard let eventId = event.id else { return }
        
        inviteManager.createInvite(for: eventId, to: userId)
        selectedParticipants.insert(userId)
    }
    
    // MARK: - Profile Image View
    private var profileImageView: some View {
        ZStack {
            Circle()
                .fill(Color.purple)
                .frame(width: 60, height: 60)
            if let usernameInitial = user.name?.first {
                Text(String(usernameInitial).capitalized)
                    .font(.tahoma(.primaryButton))
                    .foregroundStyle(.white)
                    .accessibilityLabel("Símbolo do usuário")
            }
        }
    }
    
    // MARK: - Role Tag
    private var roleTag: some View {
        HStack {
            if let userRole = user.role {
                Text(userRole.rawValue)
                    .font(.tahoma(.regular, size: 14))
                    .foregroundStyle(.black)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
        }
    }
}

