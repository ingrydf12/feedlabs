//
//  SucessRedefView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 01/08/24.
//

import SwiftUI

struct SucessRedefView: View {
    
    let coordinator: AuthCoordinator
    
    var body: some View {
            VStack{
                Image("sucess_reset")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 206 , height: 184.92)
                
                VStack{
                    Text("O email foi enviado!")
                        .font(.tahoma(.title))
                        .padding(10)
                    Text("Cheque suas mensagens e acesse o link para continuar")
                        .font(.tahoma(.secondaryButton))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.gray)
                }
                
            }
            .statusBar(hidden: true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    coordinator.navigateTo(screen: .login)
                }
            }

    }
        
}

struct SucessViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        SucessRedefView(coordinator: coordinator)
    }
}

#Preview {
    SucessViewContainer()
}
