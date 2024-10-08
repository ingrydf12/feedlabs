//
//  buttonView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 02/08/24.
//

import SwiftUI

struct buttonView: View {
    let name: String
    let background: Color
    var action: () -> Void
    var body: some View {
        Button{
            action()
        }label: {
            ZStack{
                
                RoundedRectangle(cornerRadius: 28)
                    .foregroundColor(background)
                    .padding()
                    .frame(width: 329 ,height: 75)
                Text(name)
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .bold()
            }
            
        }
    }
}

#Preview {
    buttonView(name: "teste", background: Color.darkAqua) {
        
    }
}
