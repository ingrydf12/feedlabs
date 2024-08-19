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

            EventsListView(groupedEvents: viewModel.groupedEventsByHour())
        }
        .navigationTitle("Reuniões")
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

        }.padding()
        .background(Color.background)
    }
}

#Preview {
    HomeView()
}

