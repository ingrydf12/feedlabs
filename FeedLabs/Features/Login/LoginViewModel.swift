//
//  LoginViewModel.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 06/08/24.
//

import Foundation
import FirebaseAuth


class LoginViewModel: ObservableObject {
    
    let coordinator: AuthCoordinator
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    
    func handleLogin(){
        
        guard isValid else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.emailError = "Não pode estar em branco"
                self.passwordError = "Não pode estar em branco"
                return
            }
            guard let user = result?.user else { return }
            print("User logged successfully with uid: \(user.uid)")
        }
    }
    
    var isValid: Bool {
        emailError = email.isEmpty ? "Não pode estar em branco" : nil
        passwordError = password.isEmpty ? "Não pode estar em branco" : nil
        return emailError == nil && passwordError == nil
    }
}
