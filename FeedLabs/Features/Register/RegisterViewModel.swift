//
//  RegisterViewModel.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 07/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject{
    
    let coordinator: AuthCoordinator
        
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var name: String = ""
        @Published var role: String? = nil
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    func handleRegister() {
        if !isValidEmail(email) || password.count < 6 {
            return
        }
        createUser()
        
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
            
            let newUser = User(id: user.uid, name: self.name, email:
                                self.email, role: self.role)
            UserManager.shared.addUser(user: newUser)
        }
    }

}
