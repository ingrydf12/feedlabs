//
//  RegisterView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct TestRegisterView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var role: String = ""
    
    
    var body: some View {
        VStack{
            Text("Nome:")
            HStack{
                TextField("", text: $name, prompt: Text("name").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
            Text("Funcao:")
            HStack{
                TextField("", text: $role, prompt: Text("funcao").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
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
                handleRegister()
            }, label: {
                VStack{
                    Text("Register").foregroundStyle(Color.white).bold().padding()
                }.background(Color.pink).cornerRadius(18)
            })
        }
    }
    func handleRegister() {
        if !isValidEmail(email) || password.count < 6 {
            return
        }
        createUser()
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func createUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            print("User created successfully with uid: \(user.uid)")
            
            let newUser = User(id: user.uid, name: name, email: email, role: role)
            UserManager.shared.addUser(user: newUser)
        }
    }
}

#Preview {
    TestRegisterView()
}
