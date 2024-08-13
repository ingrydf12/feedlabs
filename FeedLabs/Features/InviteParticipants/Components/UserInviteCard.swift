//
//  UserInviteCard.swift
//  FeedLabs
// =)
//  Created at 13/08/24.
//

import SwiftUI

struct UserInviteCard: View {
    @Binding var event: String
    
    @StateObject private var userManager = UserManager.shared
    @StateObject private var inviteManager = InviteManager.shared
    @State private var selectedParticipants: Set<String> = []
    
    var body: some View {
        HStack(alignment: .center){
            //Identifier: Symbol with initial letter
            profileImageView
                .padding(15)
            VStack(alignment: .leading, spacing: 8){
                if let user = userManager.user{
                    Text(user.name ?? "sem nome")
                        .font(.tahoma(.bold, size: 24))
                }
                //Tag: ROLE
                roleTag
            }
            Spacer()
            //Invite (Botão foda)
            List(UserManager.shared.users) { user in
                if UserManager.shared.user?.id != user.id {
                    HStack {
                        Text(user.name ?? "")
                        Spacer()
                        if selectedParticipants.contains(user.id ?? "") {
                            // Value: Selected
                            Image(systemName: "person.fill.checkmark")
                                .foregroundStyle(Color.blue)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        } else {
                            //Value: Default
                            Image(systemName: "person.badge.plus")
                                .foregroundColor(.cyan)
                                .background(Circle().fill(Color.cyan.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        }
                    }
                    .contentShape(Rectangle())
                    .frame(height: 48)
                    .onTapGesture {
                        if selectedParticipants.contains(user.id ?? "") {
                            selectedParticipants.remove(user.id ?? "")
                        } else {
                            selectedParticipants.insert(user.id ?? "")
                        }
                    }
                }
            }
            
                
        }.padding(5)
            .frame(maxWidth: 350)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(style: StrokeStyle(lineWidth: 2.0))
                    .foregroundStyle(Color.accentColor)
            )
    }
    
    
    //Ícone incrível com inicial do nome
    private var profileImageView: some View {
        ZStack {
            Circle()
                .fill(Color.purple)
                .frame(width: 60, height: 60)
            if let usernameInitial = userManager.user?.name?.first {
                Text(String(usernameInitial))
                    .font(.tahoma(.primaryButton))
                    .foregroundStyle(Color.white)
            }
        }
    }
    
    // Role TAG
    private var roleTag: some View{
        HStack{
            if let userRole = userManager.user?.role{
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

