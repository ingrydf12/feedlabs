//
//  LoginView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 24/07/24.
//

import SwiftUI
import FirebaseAuth

struct TestLoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            Text("Email:")
            HStack{
                TextField("", text: $email, prompt: Text("Email").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
            
            Text("Senha:")
            HStack{
                TextField("", text: $password, prompt: Text("Senha").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
            
            Button(action: {
                handleLogin()
            }, label: {
                VStack{
                    Text("Login").foregroundStyle(Color.white).bold().padding()
                }.background(Color.pink).cornerRadius(18)
            })
        }
    }
    func handleLogin(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let user = result?.user else { return }
            print("User logged successfully with uid: \(user.uid)")
        }
    }
}

#Preview {
    TestLoginView()
}
