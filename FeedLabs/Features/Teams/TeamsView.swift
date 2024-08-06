//
//  TeamsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct TeamsView: View {
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Teams")
                    .padding(.vertical,5)
                    .padding(.horizontal,150)
            }
            .background(Color.clearGray)
            .cornerRadius(15)
            Spacer()
        }.padding(.top,15)
        
    }
}

#Preview {
    TeamsView()
}
