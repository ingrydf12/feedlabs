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

    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    func handleLogin(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let user = result?.user else { return }
            print("User logged successfully with uid: \(user.uid)")
        }
    }
    
}
