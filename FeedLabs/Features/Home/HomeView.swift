//
//  HomeView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//
import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    @State private var inviteManager = InviteManager.shared
    @State private var userManager = UserManager.shared
    @State private var eventManager = EventManager.shared
    
    @State private var showAlert = false
    @State private var navigateToInvites = false
    
    var body: some View {
        VStack {
            CalendarView(selectedDate: $viewModel.selectedDate)

            Spacer()
            
            Text("Eventos de hoje")
                .font(.tahoma(.bold, size: 24))
            
            EventsListView(groupedEvents: viewModel.groupedEventsByHour())
           
            NavigationLink(destination: InvitesView(), isActive: $navigateToInvites) {
//                EmptyView()
            }
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
        }
        .padding()
//        .background(Color.background)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Você tem convites pendentes!"),
                primaryButton: .default(Text("Ver Todos")) {
                    navigateToInvites = true
                    showAlert = false
                },
                secondaryButton: .cancel(Text("Ignorar"))
            )
        }
        .onAppear {
            if inviteManager.pendingInvitesCount > 0 {
                showAlert = true
            }
        }
    }
}

#Preview {
    HomeView()
}
