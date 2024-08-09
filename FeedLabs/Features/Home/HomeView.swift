//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(viewModel.userManager.user?.id ?? "nil")")
            Text("NAME: \(viewModel.userManager.user?.name ?? "nil")")
            
            Text("Eventos de hoje")
                .font(.tahoma(.subtitle))
            
            
            let dateFormatter = DateFormatter()
            
            if let events = EventManager.shared.events {
                ForEach(events) { event in
                    VStack {
                        Text("AAAAAAAAAAA")
                        
                    }
                }
            }
        }
        .padding()
        .onAppear {
            EventManager.shared.getEvents()
        }
    }
}

#Preview {
    HomeView()
}
