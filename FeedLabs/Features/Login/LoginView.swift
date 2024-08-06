//
//  LoginView.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 24/07/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State var viewModel: LoginViewModel
    
    init(coordinator: AuthCoordinator) {
        self.viewModel = LoginViewModel(coordinator: coordinator)
    }
    
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
                TextField("", text: $viewModel.email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
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
                SecureField("", text: $viewModel.password, prompt: Text("Insira sua senha").foregroundColor(.gray))
                    .autocapitalization(.none)
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            }
            .frame(width: 344, height: 46)
            .border(Color.gray)
            
            Button {
                viewModel.coordinator.navigateTo(screen: .passwordRecovery)
            } label: {
                VStack{
                    Text("Esqueceu sua senha?").foregroundStyle(Color.darkAqua).bold()
                    //pegar componente para botao que vai ser muito utilizado
                }
               
                .padding()
            }

            
            buttonView(name: "Entrar", background: Color.darkAqua) {
                viewModel.handleLogin()
            }
            
            HStack{
                Text("Não tem uma conta?")
                Button {
                    print("teste")
                } label: {
                    Text("Cadastre-se").foregroundStyle(Color.darkAqua).bold()
                        
                }
                
                
            }
            .offset(y: 60)
            
        }
    }
   
}

struct LoginViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        LoginView(coordinator: coordinator)
    }
}

#Preview {
    LoginViewContainer()
}

