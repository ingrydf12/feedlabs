//
//  ResetpasswordView.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 31/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RecoverPasswordView: View {

    
    @State var viewModel: RecoverPasswordViewModel
    
    init(coordinator: AuthCoordinator) {
        self.viewModel = RecoverPasswordViewModel(coordinator: coordinator)
    }
    
    
    var body: some View {
            VStack{
                HStack{
                    Button(action:{
                        viewModel.coordinator.navigateTo(screen: .login)
                    }){
                        
                        Image("Back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)

                    }
                    .foregroundStyle(.accent)
                    .padding(.leading,35)
                    Spacer()
                }
                Spacer()
                
                Image("redef_senha")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 136.9)
                Text("Redefinição de senha!")
                    .font(.tahoma(.title))

                Text("Informe um email cadastrado e enviaremos um link para recuperação da sua senha")
                    .font(.tahoma(.body))
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 20)
//                    .foregroundStyle(Color.gray)
                VStack(alignment: .leading){
                    Text("E-mail")
                        .font(.tahoma(.secondaryButton))
                        .padding(.trailing,50)
                    HStack{

                        TextField("", text: $viewModel.email,prompt: Text("Insira seu e-mail")
                            .foregroundStyle(Color(uiColor: .systemGray2)))
                        .padding(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(width: 332, height: 48)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                        
                    }
                  
                }
                
                buttonView(name: "Enviar link de recuperação", background: .accent) {
                    UserManager.shared.checkIfEmailExists(email: viewModel.email) { exists in
                        if exists {
                            viewModel.sendPasswordReset(email: viewModel.email)
                            viewModel.coordinator.navigateTo(screen: .sucessRedefView)
                        }
                    }
                    
                    
                }
                .foregroundStyle(.primary)
                .font(.tahoma(.secondaryButton))
                Spacer()

                
                if viewModel.isSucess == false{
                    Text(viewModel.errormessage)
                        .foregroundStyle(Color.red)
                        .padding()
                }
            }
            
            
        
    }
    
}

struct RecoveryViewContainer: View {
    
    @StateObject var coordinator = AuthCoordinator()

    var body: some View {
        RecoverPasswordView(coordinator: coordinator)
    }
}

#Preview {
    RecoveryViewContainer()
}
