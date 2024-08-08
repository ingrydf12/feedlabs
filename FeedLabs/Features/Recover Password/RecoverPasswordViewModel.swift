//
//  RecoverPasswordViewModel.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 07/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RecoverPasswordViewModel: ObservableObject{
    
    let coordinator: AuthCoordinator
    
    @Published  var email: String = ""
    @Published  var errormessage: String?
    @Published  var isSucess: Bool = false
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    func sendPasswordReset(email: String) {
        errormessage = nil
        isSucess = false
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
              
                self.errormessage = ("Insira um email válido")
            } else {
               
                self.isSucess = true
                self.errormessage = nil
            }
        }
    }
    
    
}
