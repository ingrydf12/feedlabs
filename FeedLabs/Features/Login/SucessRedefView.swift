//
//  SucessRedefView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 01/08/24.
//

import SwiftUI

struct SucessRedefView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
            VStack{
                Image("sucess_reset")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 206 , height: 184.92)
                
                VStack{
                    Text("O email foi enviado!")
                        .bold()
                        .font(.title2)
                        .padding(10)
                    Text("Cheque suas mensagens e acesse o link para continuar")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.gray)
                }
                
            }
            .statusBar(hidden: true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $isActive){
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
    }
        
}

#Preview {
    SucessRedefView()
}
