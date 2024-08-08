//
//  NoEventCard.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 08/08/24.
//

import SwiftUI

struct NoEventCard: View {
    var body: some View {
        VStack(alignment: .center){
            Image("imageNoEvent")
                .scaledToFit()
            Text("Parece que você não tem nenhum evento para hoje.")
                .multilineTextAlignment(.center)
                .font(.headline) // Change to Tahoma Main Text (16pt)
                .fontWeight(.bold)
        }.frame(width: 320, height: 290)
    }
}

#Preview {
    NoEventCard()
}
