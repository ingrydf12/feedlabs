//
//  firstScreenView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 06/08/24.
//

import SwiftUI

struct firstScreenView: View {
    
    @State private var isActive: Bool = false
    var body: some View {
        VStack{
            Image("firstScreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 185)
        }
        .statusBar(hidden: true)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
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
    firstScreenView()
}
