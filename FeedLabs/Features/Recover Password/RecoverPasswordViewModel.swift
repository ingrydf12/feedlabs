//
//  RecoverPasswordViewModel.swift
//  FeedLabs
//
//  Created by Guilherme Pessoa on 07/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class RecoverPasswordViewModel: ObservableObject{
    
    let coordinator: AuthCoordinator
    
      var email: String = ""
      var errormessage: String = ""
      var isSucess: Bool = false
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    func sendPasswordReset(email: String) {
       
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                self.isSucess = false
                self.errormessage = ("Insira um email válido")
            } else {
               
                self.isSucess = true
                self.errormessage = ""
            }
        }
    }
    
    
}
