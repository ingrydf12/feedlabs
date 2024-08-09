//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    private var viewModel = HomeViewModel()    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "H"
            return formatter
        }()
    
    var body: some View {
        NavigationStack {
            Text("ID: \(viewModel.userManager.user?.id ?? "nil")")
            Text("NAME: \(viewModel.userManager.user?.name ?? "nil")")
            
            Text("Eventos de hoje")
                .font(.tahoma(.subtitle))
            
            
            if !viewModel.eventManager.events.isEmpty {
                
                ForEach(viewModel.eventManager.events) { event in
                    Text("\(event.name!) | \(dateFormatter.string(from: event.date!))")
                }
            } else {
                Group {
                    Image("imageNoEvent")
                    Text("Parece que você não tem nenhum evento para hoje").font(.tahoma(.body))
                        .multilineTextAlignment(.center)
                }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Eventos")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                AddEvent()
            }
        })
        
        .padding()
    }
}

#Preview {
    HomeView()
}
