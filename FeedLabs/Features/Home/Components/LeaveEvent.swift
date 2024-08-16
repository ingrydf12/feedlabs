//
//  LeaveEvent.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 14/08/24.
//

import SwiftUI

struct LeaveEvent: View {
    @StateObject private var viewModel: LeaveEventViewModel
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    init(event: Event) {
        _viewModel = StateObject(wrappedValue: LeaveEventViewModel(event: event))
    }
    
    var body: some View {
        ZStack {
            if viewModel.showPopup {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    popupContent
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .overlay(
                            Button(action: {
                                viewModel.showPopup = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.darkAqua)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(),
                            alignment: .topTrailing
                        )
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: viewModel.showPopup)
            }
        }
    }
    
    var popupContent: some View {
        VStack(alignment: .center, spacing: 16) {
            // Title and Creator
            Text(viewModel.event.name ?? "Evento sem nome")
                .font(.tahoma(.bold, size: 24))
            Text(viewModel.event.owners.first ?? "Criador desconhecido")
                .font(.tahoma(.regular, size: 16))
                .foregroundColor(.gray)
            
            // Date and Time
            HStack {
                Image(systemName: "calendar")
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.darkAqua)
                    .background(
                        Circle()
                            .foregroundStyle(.darkAqua.opacity(0.2))
                    )
                
                Text(Self.dateFormatter.string(from: viewModel.event.date ?? Date()))
                    .font(.tahoma(.regular, size: 16))
                    .foregroundColor(Color.black)
                
                Spacer()
                
                Image(systemName: "clock")
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.darkAqua)
                    .background(
                        Circle()
                            .foregroundStyle(.darkAqua.opacity(0.2))
                    )
                
                Text(Self.timeFormatter.string(from: viewModel.event.date ?? Date()))
                    .font(.tahoma(.regular, size: 16))
                    .foregroundColor(Color.black)
            }
            .padding(10)
            
            Rectangle()
                .frame(height: 4)
                .foregroundColor(Color.clearGray)
                .cornerRadius(20)
            
            Button(action: {
                viewModel.leaveEvent()
            }) {
                Text("Confirmar Saída")
                    .font(.tahoma(.bold, size: 18))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.top, 20)

        }
        .padding()
    }
}
