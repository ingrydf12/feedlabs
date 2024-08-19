//
//  InputField.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 18/08/24.
//

import Foundation
import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    var error: String?
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.tahoma(.secondaryButton))
                    .padding(.leading, 25)
                Spacer()
            }
            
            HStack {
                TextField("", text: $text, prompt: Text("Insira seu \(title.lowercased())").foregroundColor(.gray))
                    .foregroundColor(.gray)
                    .autocorrectionDisabled()
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(error != nil ? Color.red : Color.gray, lineWidth: 1)
            }
            
            if let error = error {
                Text(error)
                    .foregroundStyle(Color.red)
                    .padding(.leading, 25)
                    .padding(.top, 5)
            }
        }
    }
}
