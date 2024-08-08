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
                }){
                    
                    Image("Back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                }
                .padding(.leading,35)
                Spacer()
                VStack{
                    Text("Cadastro")
                }
                    .foregroundStyle(Color.darkAqua)
                    .bold()
                    .padding(.trailing,60)
                Spacer()
                    
                
            }
            .padding()
            Spacer()
            
            VStack{
                Text("Você é:")
                    .bold()
                    .font(Font.custom("Tahoma", size: 32))
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
                                .background(viewModel.role == "Residente" ? Color.blue.opacity(1.2) : Color.clear)
                        }
                        
                        Button(action: {
                            
                            viewModel.role = "Mentor"
                            print("hoho")
                            
                        }) {
                            Image("MentorButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160,height: 168)
                                .background(viewModel.role == "Mentor" ? Color.blue.opacity(1.2) : Color.clear)
                        }
                    
                }
                Spacer()
            }
            VStack{
                    HStack{
                        Text("Nome de usuário")
                            .padding(.leading, 25)
                        Spacer()
                    }
                    
                    HStack{
                        TextField("", text: $viewModel.name, prompt: Text("Insira seu nome").foregroundColor(.gray))
                            .foregroundColor(.gray)
                            .autocapitalization(.none)
                            .padding(.leading, 20)
                    }
                    .frame(width: 344, height: 46)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray,lineWidth: 1)
                    }
                
                Spacer()
                HStack{
                    Text("E-mail")
                        .padding(.leading, 25)
                    Spacer()
                }
                
                HStack{
                    TextField("", text: $viewModel.email, prompt: Text("Insira seu e-mail").foregroundColor(.gray))
                        .foregroundColor(.gray)
                        .autocapitalization(.none)
                        .padding(.leading, 20)
                }
                .frame(width: 344, height: 46)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray,lineWidth: 1)
                }
            
            Spacer()
                HStack{
                    Text("Senha")
                        .padding(.leading, 25)
                    Spacer()
                }
                
                HStack{
                    SecureField("", text: $viewModel.password, prompt: Text("Insira sua senha").foregroundColor(.gray))
                        .autocapitalization(.none)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                    
                }
                
                .frame(width: 344, height: 46)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray,lineWidth: 1)
                }
            
            Spacer()
                
                buttonView(name: "Entrar", background: Color.darkAqua) {
                    viewModel.handleRegister()
                    viewModel.coordinator.navigateTo(screen: .login)
                }
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

