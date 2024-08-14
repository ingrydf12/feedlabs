//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        VStack{
            CalendarView(selectedDate: $viewModel.selectedDate)
                Spacer()
                
            Text("Eventos de hoje")
                .font(.tahoma(.subtitle))

            EventsListView(groupedEvents: viewModel.groupedEventsByHour())
                .frame(alignment: .center)
        }
        .navigationTitle("Eventos")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                UserProfileButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: {
                    AddEventView()
                }, label: {
                    Image(systemName: "plus")
                })
            }

        }
        .padding(.horizontal, 16)
        .background(Color.background)
    }
}

#Preview {
    HomeView()
}

