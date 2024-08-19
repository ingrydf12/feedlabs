//
//  RegisterView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    
    @State var viewModel: RegisterViewModel
    
    init(coordinator: AuthCoordinator) {
        self.viewModel = RegisterViewModel(coordinator: coordinator)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.coordinator.navigateTo(screen: .login)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.darkAqua)
                        .padding(.leading)
                }
                Spacer()
                Text("Cadastro")
                    .font(.tahoma(.secondaryButton))
                    .foregroundStyle(Color.darkAqua)
                    .padding(.trailing)
                Spacer()
            }
            .padding()
            
            VStack(spacing: 20) {
                Text("Você é:")
                    .font(.tahoma(.primaryButton))
                
                HStack {
                    Button(action: {
                        viewModel.role = "Residente"
                    }) {
                        Image("ResidentButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160, height: 168)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.role == "Residente" ? Color.darkAqua : Color.clear, lineWidth: 3)
                            )
                    }
                    
                    Button(action: {
                        viewModel.role = "Mentor"
                    }) {
                        Image("MentorButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160, height: 168)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.role == "Mentor" ? Color.darkAqua : Color.clear, lineWidth: 3)
                            )
                    }
                }
                
                if let roleError = viewModel.roleError {
                    Text(roleError)
                        .foregroundStyle(Color.red)
                        .padding(.top, 5)
                }
            }
            .padding(.top)
            
            VStack(spacing: 20) {
                InputField(title: "Nome de usuário", text: $viewModel.name, error: viewModel.nameError)
                
                InputField(title: "E-mail", text: $viewModel.email, error: viewModel.emailError)
                
                VStack {
                    HStack {
                        Text("Senha")
                            .font(.tahoma(.secondaryButton))
                            .padding(.leading, 25)
                        Spacer()
                    }
                    HStack {
                        showPassword(text: $viewModel.password, title: "Insira sua senha")
                            .foregroundStyle(Color.gray)
                            .padding()
                            .frame(width: 344, height: 46)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.passwordError != nil ? Color.red : Color.gray, lineWidth: 1.0)
                            }
                    }
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundStyle(Color.red)
                            .padding(.leading, 25)
                            .padding(.top, 5)
                    }
                }
                
                buttonView(name: "Cadastrar", background: Color.darkAqua) {
                    viewModel.handleRegister()
                }
                .font(.tahoma(.secondaryButton))
            }
            .padding(.top,20)
            Spacer()
        }
    }
}

struct RegisterViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        RegisterView(coordinator: coordinator)
    }
}

#Preview {
    RegisterViewContainer()
}
