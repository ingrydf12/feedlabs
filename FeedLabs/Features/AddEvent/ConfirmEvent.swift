//
//  ConfirmEvent.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 08/08/24.
//

import SwiftUI

struct ConfirmEvent: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Marcado!")
                .font(.title) //Change font to Tahoma Title (32)
                .fontWeight(.bold)
            
            Text("Seu evento foi criado com sucesso.")
                .multilineTextAlignment(.center)
            
            Image("imageConfirmEvent")
                .resizable()
                .scaledToFit()
                .frame(width: 275, height: 190)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Tela anterior
            }) {
                Text("Criar outro evento")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .buttonStyle(PrimaryButton())
            
            //Button Navigation Home
//            NavigationLink(destination: TestHomeView()) {
//                Text("Voltar para o calendário")
//                    .font(.body)
//                    .fontWeight(.bold)
//            }
//            .buttonStyle(SecondaryButton())
        }
        .padding()
        .frame(width: 360, height: 420)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 4)
    }
}



#Preview {
    ConfirmEvent()
}

