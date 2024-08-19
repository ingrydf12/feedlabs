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
            
            HStack{
                Button(action:{
                    viewModel.coordinator.navigateTo(screen: .login)
                })
                {
                    
                    Image("Back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                }
                .accessibilityLabel("Botão de voltar")
                .padding(.leading,35)
                Spacer()
                VStack{
                    Text("Cadastro")
                        .font(.tahoma(.secondaryButton))
                }
                    .foregroundStyle(Color.darkAqua)
                    .padding(.trailing,60)
                Spacer()
                    
                
            }
            .padding()
            Spacer()
            
            VStack{
                Text("Você é:")
                    .font(.tahoma(.primaryButton))
                   
                Spacer()
                HStack{
                    Button(action: {
                            
                        viewModel.role = "Residente"
                        print("haha")
                            
                        }) {
                            Image("ResidentButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160, height: 168)
                                .background(viewModel.role == "Residente" ? Color.darkAqua.opacity(2) : Color.clear)
                        }
                        .accessibilityLabel("Residente foi escolhido")
                        Button(action: {
                            
                            viewModel.role = "Mentor"
                            print("hoho")
                            
                        }) {
                            Image("MentorButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160,height: 168)
                                .background(viewModel.role == "Mentor" ? Color.darkAqua.opacity(2) : Color.clear)
                        }
                    
                }
                .accessibilityLabel("Mentor foi escolhido")
                Spacer()
                    if let roleError = viewModel.roleError {
                        Text(roleError)
                            .foregroundStyle(Color.red)
                            .padding(.leading,25)
                            .padding(.top,5)
                    }
                
            }
            VStack{
                    HStack{
                        Text("Nome de usuário")
                            .font(.tahoma(.secondaryButton))
                            .padding(.leading, 25)
                        Spacer()
                    }
                    
                    HStack{
                        TextField("", text: $viewModel.name, prompt: Text("Insira seu nome").foregroundColor(.gray))
                            .accessibilityHint("Insira seu nome")
                            .foregroundColor(.gray)
                            .autocorrectionDisabled()
                            .padding(.leading, 20)
                    }
                    .frame(width: 344, height: 46)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.nameError != nil ? Color.red : Color.gray,lineWidth: 1)
                    }
                
                if let nameError = viewModel.nameError{
                    Text(nameError)
                        .foregroundStyle(Color.red)
                        .padding(.leading,25)
                        .padding(.top,5)
                }
                
                Spacer()
                HStack{
                    Text("E-mail")
                        .font(.tahoma(.secondaryButton))
                        .padding(.leading, 25)
                    Spacer()
                }
                
                HStack{
                    TextField("", text:$viewModel.email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
                        .accessibilityHint("Insira seu e-email")
                        .foregroundColor(.gray)
                        .autocorrectionDisabled()
                        .padding(.leading, 20)
                }
                .frame(width: 344, height: 46)
                .overlay{
                        RoundedRectangle(cornerRadius: 10)
                        .stroke (viewModel.emailError != nil ? Color.red : Color.gray,lineWidth: 1)
                }
                if let emailError = viewModel.emailError {
                    Text(emailError)
                        .foregroundStyle(Color.red)
                        .padding(.leading,25)
                        .padding(.top,5)
                }
            
            Spacer()
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
                            .padding(.leading,20)
                            .frame(width: 344, height: 46)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.passwordError != nil ? Color.red : Color.gray, lineWidth: 1.0)
                            }
                    }
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundStyle(Color.red)
                            .padding(.leading,25)
                            .padding(.top,5)
                    }

                
                }
                Spacer()

                
                buttonView(name: "Entrar", background: Color.darkAqua) {
                    
                    viewModel.handleRegister()
                    
                }
                .accessibilityLabel("Botão de entrar")
                .font(.tahoma(.secondaryButton))
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

