//
//  firstScreenView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 06/08/24.
//

import SwiftUI

struct EntryView: View {
    
    let coordinator: AuthCoordinator
    
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
                coordinator.navigateTo(screen: .login)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct EntryViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        EntryView(coordinator: coordinator)
    }
}

#Preview {
    EntryViewContainer()
}
