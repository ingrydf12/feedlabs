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
                    .padding(.leading,35)
                    Spacer()
                }
                Spacer()
                
                Image("redef_senha")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 206 , height: 136.9)
                Text("Redefinição de senha!")
                    .bold()
                    .font(.title2)
                
                Text("Informe um email cadastrado e enviaremos um link para recuperação da sua senha")
                    .multilineTextAlignment(.center)
                    .padding(20)
                    .foregroundStyle(Color.gray)
                VStack(alignment: .leading){
                    Text("E-mail")
                        .padding(.trailing,50)
                    HStack{
                        TextField("", text: $viewModel.email, prompt: Text("Insira seu e-mail")
                            .foregroundColor(.gray)
                                  
                        )
                        .padding(10)
                        .foregroundColor(.gray)
                        .autocorrectionDisabled()
                       
                        
                    }
                    .frame(width: 332, height: 48)
                    .cornerRadius(10)
                    .border(Color.gray)
                  
                }
                
                buttonView(name: "Enviar link de recuperação", background: Color.darkAqua) {
                    viewModel.sendPasswordReset(email: viewModel.email)
                    viewModel.coordinator.navigateTo(screen: .sucessRedefView)
                }
                Spacer()

                if let errormessage = viewModel.errormessage {
                    Text(errormessage)
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
