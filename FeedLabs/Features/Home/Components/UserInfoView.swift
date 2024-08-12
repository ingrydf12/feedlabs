//
//  UserInfoView.swift
//  FeedLabs
//
//  Created by User on 12/08/24.
//

import SwiftUI

struct UserInfoView: View {
    let userManager: UserManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ID: \(userManager.user?.id ?? "nil")")
            Text("Name: \(userManager.user?.name ?? "nil")")
        }
    }
}

#Preview {
    UserInfoView(userManager: UserManager.shared)
}
