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
    
  //  @StateObject var usermanager = UserManager
    let coordinator: AuthCoordinator
    
    @State private var email: String = ""
    @State private var errormessage: String?
    @State private var isSucess: Bool = false
    
    var body: some View {
            VStack{
                HStack{
                    Button(action:{
                        coordinator.navigateTo(screen: .login)
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
                        TextField("", text: $email, prompt: Text("Insira seu e-mail")
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
                    sendPasswordReset(email: email)
                    coordinator.navigateTo(screen: .sucessRedefView)
                }
                Spacer()

                if let errormessage = errormessage {
                    Text(errormessage)
                        .foregroundStyle(Color.red)
                        .padding()
                        .offset(y:50)
                }
            }
            
            
        
    }
    func sendPasswordReset(email: String) {
        errormessage = nil
        isSucess = false
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                // Ocorreu um erro ao enviar o email de redefinição de senha
                self.errormessage = ("Insira um email válido")
            } else {
                // Email de redefinição de senha enviado com sucesso
                self.isSucess = true
                self.errormessage = nil
            }
        }
    }
    
    
//    func fetchUser() {
//        guard let userId = AuthManager.shared.userId else { return }
//
//        let db = Firestore.firestore()
//        let ref = db.collection("Users").document(userId)
//
//        ref.getDocument { document, error in
//            if let error = error {
//                print("error:", error.localizedDescription)
//                return
//            }
//
//            if let document = document, document.exists {
//                self.user = try? document.data(as: User.self)
//            }
//        }
//    }
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
