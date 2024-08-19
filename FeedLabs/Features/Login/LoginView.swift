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
            VStack{
                Image("Login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 243, height: 210.51)
                   
                Spacer()
            }
            
            .padding()
            .padding(.top,10)
            .overlay(
                Color.black.opacity(0.03)
            )
            
            VStack{
                HStack{
                Text("Login")
                        .font(.tahoma(.title))
                    .bold()
                    .padding(.leading,10)
                Spacer()
            }
            .padding()
                
            VStack{
                HStack{
                    Text("E-mail")
                        .font(.tahoma(.secondaryButton))
                        .padding(.leading, 25)
                      
                    Spacer()
                }
               
                
                HStack{
                    TextField("", text: $viewModel.email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
                        .foregroundColor(.gray)
                        .autocapitalization(.none)
                        .padding(.leading, 20)
                }
                .accessibilityHint("Insira seu e-email")
                .frame(width: 344, height: 46)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(viewModel.emailError != nil ? Color.red : Color.gray,lineWidth: 1)
                }
                
                if let emailError = viewModel.emailError {
                    Text(emailError)
                        .foregroundStyle(Color.red)
                        .padding(.leading,25)
                        .padding(.top,5)
                }

            }
            Spacer()
              .padding(.bottom,10)
            
            
            VStack{
                HStack{
                    Text("Senha")
                        .font(.tahoma(.secondaryButton))
                        .padding(.leading,25)
                    Spacer()
                }
                HStack{
                    showPassword(text: $viewModel.password, title: "Insira sua senha")
                        .foregroundStyle(Color.gray)
                        .autocapitalization(.none)
                        .padding(.leading,20)
                }
                        .frame(width: 344, height: 46)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.passwordError != nil ? Color.red : Color.gray,lineWidth: 1)
                            
                        }
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundStyle(Color.red)
                            .padding(.leading,25)
                            .padding(.top,5)
                    }
                    
                

            
            }
            Spacer()
                
            
           
            HStack{
                Spacer()
                Text("Esqueceu sua senha?")
                    .accessibilityLabel("Botão de redefinir a senha")
                    .foregroundStyle(Color.darkAqua).font(.tahoma(.secondaryButton))
                    .onTapGesture {
                        viewModel.coordinator.navigateTo(screen: .passwordRecovery)
                    }
                
            }
            .padding(.trailing,25)
            
            VStack(){
                Spacer()
                    .padding()
                buttonView(name: "Entrar", background: Color.darkAqua) {
                    
                        viewModel.handleLogin()
                    
                }
                .accessibilityLabel("Botão de entrar")
                .font(.tahoma(.secondaryButton))
               
                Spacer()
                HStack{
                    Text("Não tem uma conta?")
                        .font(.tahoma(.secondaryButton))
                    Button {
                        viewModel.coordinator.navigateTo(screen: .register)
                    } label: {
                        Text("Cadastre-se").foregroundStyle(Color.darkAqua).font(.tahoma(.subtitle))
                            .accessibilityLabel("Botão de cadastro")
                        }
                    
                    }
                
                }
            }
            Spacer()
            
        }
        Spacer()
       
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

