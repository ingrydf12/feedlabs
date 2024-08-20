//
//  InvitesView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 19/08/24.
//

import SwiftUI

struct InvitesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                }
                Spacer()
                Text("Convites")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            InviteCardView(user: AuthManager.shared.userId ?? "")
        }
        .padding()
        .navigationBarBackButtonHidden()
//        .background(Color.background)
    }
}

#Preview {
    InvitesView()
}
