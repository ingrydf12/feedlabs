//
//  registerViewSucess.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 13/08/24.
//

import SwiftUI

struct SucessRegisterView: View {
    
    let coordinator: AuthCoordinator
    
    var body: some View {
            VStack{
                Image("sucessRegister")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 334 , height: 188)
                
                VStack{
                    Text("Conta criada com sucesso!")
                        .font(.tahoma(.title))
                        .padding(10)
                    Text("você será redirecionado para o aplicativo!")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.gray)
                        .font(.tahoma(.secondaryButton))
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

struct SucessRegisterViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        SucessRegisterView(coordinator: coordinator)
    }
}

#Preview {
   SucessRegisterViewContainer()
}
