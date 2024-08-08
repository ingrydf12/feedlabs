//
//  NoEventCard.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 08/08/24.
//

import SwiftUI

//MARK: - Card Event Result to Filter
struct NoEventCard: View {
    var body: some View {
        VStack(alignment: .center){
            Image("imageNoEvent")
                .resizable()
                .scaledToFit()
            Text("Parece que você não tem nenhum evento para hoje")
                .multilineTextAlignment(.center)
                .font(.headline) // Change to Tahoma Main Text (16pt)
                .fontWeight(.bold)
        }.frame(width: 320, height: 290)
    }
}

//MARK: - Card noTeam to Teams Home View
struct NoTeamCard: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Image("imageNoTeam")
                .resizable()
                .scaledToFit()
            Text("Parece que você não tem nenhum time adicionado.")
                .multilineTextAlignment(.center)
                .font(.headline) // Change to Tahoma Main Text (16pt)
                .fontWeight(.bold)
        }.frame(width: 320, height: 290)
    }
}

//MARK: - Variant Card Event Result to Filter
struct NoFilterResult: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Image("imageNoFilter") //Change to "noFilterImage" (Pedro)
                .resizable()
                .scaledToFit()
            Text("Parece que você não tem nenhum evento próximo")
                .multilineTextAlignment(.center)
                .font(.headline) // Change to Tahoma Main Text (16pt)
                .fontWeight(.bold)
        }.frame(width: 320, height: 290)
    }
}

//#Preview {
//    NoEventCard()
//}
