//
//  UserProfileButton.swift
//  FeedLabs
//
//  Created by User on 12/08/24.
//

import SwiftUI

struct UserProfileButton: View {
    private var viewModel = UserManager.shared
    
    var body: some View {
        Button {
            // Alguma ação
            AuthManager.shared.signOut()
        } label: {
            if let username = viewModel.user?.name, !username.isEmpty {
                let nameComponents = username.split(separator: " ")
                let initials = nameComponents.prefix(2).map { $0.prefix(1) }.joined()
                
                Text(initials)
                    .font(.tahoma(.primaryButton))
                    .foregroundColor(Color.primary)
                    .frame(width: 45, height: 45)
                    .background {
                        Circle()
                            .foregroundColor(Color.accentColor).opacity(0.8)
                    }
            } else {
                Text("NN")
                    .font(.tahoma(.primaryButton))
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(width: 45, height: 45)
                    .background {
                        Circle()
                            .foregroundColor(Color.accentColor).opacity(0.8)
                    }
            }
        }
    }
}

#Preview {
    UserProfileButton()
}
