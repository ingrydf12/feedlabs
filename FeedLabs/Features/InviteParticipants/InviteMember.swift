//
//  InviteMember.swift
//  FeedLabs
//
//  Created by Ingryd Cordeiro Duarte on 13/08/24.
//

import SwiftUI

struct InviteMember: View {
    @State private var searchItem: String = ""
    
    var body: some View {
        VStack{
            SearchBar(text: $searchItem, placeholder: "Buscar membros")
            
            ScrollView{}
        }
    }
}

#Preview {
    InviteMember()
}
