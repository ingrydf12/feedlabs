//
//  EmptyEventsView.swift
//  FeedLabs
//
//  Created by User on 12/08/24.
//

import SwiftUI

struct EmptyEventsView: View {
    var body: some View {
        VStack {
            Image("imageNoEvent")
            Text("Parece que você não tem nenhum evento para hoje")
                .font(.tahoma(.body))
                .multilineTextAlignment(.center)
        }
        .frame(alignment: .center)
        .padding()
    }
}

#Preview {
    EmptyEventsView()
}
