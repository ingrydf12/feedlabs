// =)
//
//FilterGenericPage.swift
// Created at 08/08/2024

import SwiftUI

struct FilterGenericPage<T: Decodable & Identifiable>: View {
    @State private var searchItem: String = ""
    @State private var items: [T] = []

    var body: some View {
        VStack {
            // Search Bar incrivelmente paia
            SearchBar(text: $searchItem, placeholder: "Buscar")
                .padding()
            
            // mostra aí os evento
            //List(filteredItems) { item in
                // detalhes
            //}
        }
        .onAppear(perform: loadItems)
    }

    // filtrar as parada
    private func filteredItems(){}
    
    // pegar os evento aí
    private func loadItems() {
    
    }
}
