// =)
//
//Feedlabs.swift
// Created at 08/08/2024

import SwiftUI

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var searchActive: Bool = false
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .scaledToFit()
                    
                    Spacer()
                    
                    Image(systemName: "mic.fill") //Voice over
                        .padding(.trailing, 8)
                }
                .padding(8)
                
                TextField(placeholder, text: $text)
                    .padding(.leading, 40)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
            }
            .foregroundColor(.gray)
        }
        .frame(height: 50)
        .padding(10)
    }
}

#Preview {
    SearchBar(text: .constant(""), placeholder: "Buscar")
}


