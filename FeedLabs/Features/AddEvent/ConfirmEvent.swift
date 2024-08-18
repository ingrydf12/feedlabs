//
//  ConfirmEvent.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 08/08/24.
//

import SwiftUI

struct ConfirmEvent: View {
    @State private var showPopup = false 
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            if showPopup {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    confirmEventPopup
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .overlay(
                            Button(action: {
                                showPopup = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                            }
                            .accessibility(label: "Botão para fechar popup e voltar a tela inicial")
                            .padding(),
                            alignment: .topTrailing
                        )
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showPopup)
            }
        }
    }
    
    var confirmEventPopup: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Marcado!")
                .font(.tahoma(.bold, size: 24))
                .accessibility(addTraits: .isHeader)
            
            Text("Seu evento foi criado com sucesso.")
                .multilineTextAlignment(.center)
                .accessibilityLabel("Evento criado com sucesso")
            
            Image("imageConfirmEvent")
                .resizable()
                .scaledToFit()
                .frame(width: 275, height: 190)
                .accessibilityLabel("Ilustração de confirmação do evento")
            
            Button(action: {
                dismiss() // Go back to the previous screen
            }) {
                Text("Criar outro evento")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .buttonStyle(PrimaryButton())
            .accessibility(label: Text("Botão para criar outro evento"))
            
            /*
            NavigationLink(destination: TestHomeView()) {
                Text("Voltar para o calendário")
                    .font(.tahoma(.regular, size: 16))
            }
            .buttonStyle(SecondaryButton())
            .accessibility(label: Text("Botão para voltar para tela inicial"))
            */
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
