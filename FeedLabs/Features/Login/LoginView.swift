//
//  LoginView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 24/07/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            
            Image("Login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 243, height: 210.51)
            
            Text("Login")
                .bold()
                .font(.title)
                .offset(x:-133)
                .padding()
            
            Text("E-mail")
                .offset(x:-146)
            HStack{
                TextField("", text: $email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
                    .foregroundColor(.gray)
                    .autocapitalization(.none)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .border(Color.gray)
       //     .background(Color.gray.cornerRadius(10.0))
            
          
            
            
            Text("Senha")
                .offset(x:-146)
            HStack{
                SecureField("", text: $password, prompt: Text("Insira sua senha").foregroundColor(.white))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .background(Color.gray.cornerRadius(10.0))
            
            Button {
                //ResetpasswordView()
            } label: {
                VStack{
                    Text("Esqueceu sua senha?").foregroundStyle(Color.darkAqua).bold()
                    //pegar componente para botao que vai ser muito utilizado
                }
                .offset(x:88,y: -20)
                .padding()
            }

            
            buttonView(name: "Entrar", background: Color.darkAqua) {
                handleLogin()
            }
            .offset(y:70)
            
            ZStack{
                Text("Não tem uma conta?")
                Button {
                    print("teste")
                } label: {
                    Text("Cadastre-se").foregroundStyle(Color.darkAqua).bold()
                        .offset(x:136)
                    
                }
                
                
            }
            .offset(x:-50,y: 60)
            
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
    LoginView()
}
