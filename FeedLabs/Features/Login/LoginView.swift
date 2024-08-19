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
        VStack {
            VStack {
                Image("Login")
                    .resizable()
                    .frame(width: 240,height: 210)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.03))
            
            VStack {
                HStack {
                    Text("Login")
                        .font(.tahoma(.title))
                        .bold()
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.bottom)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("E-mail")
                            .font(.tahoma(.secondaryButton))
                            .padding(.leading)
                        Spacer()
                    }
                    
                    HStack {
                        TextField("", text: $viewModel.email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
                            .foregroundColor(.gray)
                            .autocapitalization(.none)
                            .padding(.leading, 20)
                    }
                    .frame(width: 344, height: 46)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.emailError != nil ? Color.red : Color.gray, lineWidth: 1)
                    )
                    
                    if let emailError = viewModel.emailError {
                        Text(emailError)
                            .foregroundStyle(Color.red)
                            .padding(.leading, 25)
                            .padding(.top, 5)
                    }
                    
                    HStack {
                        Text("Senha")
                            .font(.tahoma(.secondaryButton))
                            .padding(.leading)
                        Spacer()
                    }
                    
                    HStack {
                        showPassword(text: $viewModel.password, title: "Insira sua senha")
                            .foregroundStyle(Color.gray)
                            .autocapitalization(.none)
                            .padding()
                    }
                    .frame(width: 344, height: 46)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.passwordError != nil ? Color.red : Color.gray, lineWidth: 1)
                    )
                    
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundStyle(Color.red)
                            .padding(.leading, 25)
                            .padding(.top, 5)
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Esqueceu sua senha?")
                        .foregroundStyle(Color.darkAqua)
                        .font(.tahoma(.secondaryButton))
                        .onTapGesture {
                            viewModel.coordinator.navigateTo(screen: .passwordRecovery)
                        }
                }
                .padding(.trailing)
                .padding(.top,5)
                
                VStack {
                    buttonView(name: "Entrar", background: Color.darkAqua) {
                        viewModel.handleLogin()
                    }
                    .font(.tahoma(.secondaryButton))
                    
                    HStack {
                        Text("Não tem uma conta?")
                            .font(.tahoma(.secondaryButton))
                        Button {
                            viewModel.coordinator.navigateTo(screen: .register)
                        } label: {
                            Text("Cadastre-se")
                                .foregroundStyle(Color.darkAqua)
                                .font(.tahoma(.secondaryButton))
                        }
                    }
                }
            }
            .padding()
            Spacer()
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
