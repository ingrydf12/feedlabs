//
//  RegisterViewModel.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 07/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class RegisterViewModel{
    
    let coordinator: AuthCoordinator
        
         var email: String = ""
         var password: String = ""
         var name: String = ""
         var role: String = ""
         var emailError: String?
         var passwordError: String?
         var nameError: String?
         var roleError: String?
    
    
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func validateInputs() -> Bool {
        var isValid = true
        
        if email.isEmpty {
            emailError = "O campo não pode estar vazio."
            isValid = false
        } else if !isValidEmail(email) {
            emailError = "Insira um e-mail válido."
            isValid = false
        } else {
            emailError = nil
        }
        
        if password.isEmpty {
            passwordError = "O campo não pode estar vazio."
            isValid = false
        } else {
            passwordError = nil
        }
        
        if name.isEmpty {
            nameError = "O campo não pode estar vazio"
            isValid = false
        } else {
            nameError = nil
        }
        
        if role.isEmpty {
            roleError = "Selecione um cargo"
            isValid = false
        } else{
            roleError = nil
        }
        
        return isValid
    }
    
    
    func handleRegister() {
        if validateInputs(){
            createUser()
            coordinator.navigateTo(screen: .sucessRegisterView)
        }
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func createUser() {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                print("User created successfully with uid: \(user.uid)")
                
                let newUser = User(id: user.uid, name: self.name, email: self.email, role: Role(rawValue: self.role))
                UserManager.shared.addUser(user: newUser)
                
                self.coordinator.navigateTo(screen: .sucessRegisterView)
            }
        
    }
}
