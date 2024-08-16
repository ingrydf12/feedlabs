//
//  showPassword.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 09/08/24.
//

import SwiftUI

struct showPassword: View {
    @Binding  var text: String
    var title: String
    @State  var isSecured: Bool = true
    
    var body: some View {
        
        HStack{
            
            Image(systemName: "lock.fill")
                .foregroundStyle(Color.gray)
               
            ZStack(alignment: .trailing) {
                
                Group{
                    if isSecured {
                                SecureField(title, text: $text).foregroundStyle(Color.gray)
                            .autocorrectionDisabled()
                                 
                    } else {
                                TextField(title, text: $text).foregroundStyle(Color.gray)
                            .autocorrectionDisabled()
                    }
                }
                
                Button(action: {
                    isSecured.toggle()
                }) {
                   
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .foregroundStyle(Color.gray)
                        
                    
                    
                }
               
            }
            
        }
    }
}


#Preview {
    showPassword(text: .constant(""), title: "Senha")
}
