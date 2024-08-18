//
//  ChatCard.swift
//  FeedLabs
// First Chat, Historic, New message (not read)
// =)
//  Created at 12/08/24.

import SwiftUI

struct ChatCard: View {
    @StateObject private var userManager = UserManager.shared

    var body: some View {
        HStack(alignment: .center) {
            profileImageView
            Spacer()
            userInfoView
            Spacer()
        }
        .padding(15)
        .frame(minWidth: 370)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(style: StrokeStyle(lineWidth: 2.0))
                .foregroundStyle(Color.accentColor)
        )
    }

    // Circulo incrível
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

    private var userInfoView: some View {
        VStack(alignment: .center) {
            if let user = userManager.user {
                Text(user.name ?? "Unknown User")
                    .font(.tahoma(.bold, size: 24))
                    .foregroundStyle(Color.black)
            }
            //Primeiro Chat: "Clique para iniciar um chat
            //Histórico, sem mensagens novas: "Ver histórico de chat"
            //New message: "Nova mensagem não-lida"
            Text("Status")
                .font(.tahoma(.regular, size: 16))
                .foregroundStyle(Color.black)
        }
    }
    
    //enum StatusChatMessage{}
}

#Preview{
    ChatCard()
}
