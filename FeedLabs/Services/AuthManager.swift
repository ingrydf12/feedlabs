//
//  AuthManager.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import FirebaseAuth

@Observable
class AuthManager {
    static let shared = AuthManager()

    var isAuthenticated: Bool = false
    var userId: String?

    private init() {
        print("init Auth Manager")
        self.isAuthenticated = Auth.auth().currentUser != nil
        self.userId = Auth.auth().currentUser?.uid
        
        Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            self.userId = user?.uid
            if self.isAuthenticated {
                EventManager.shared.getEvents()
            }
            UserManager.shared.fetchUser()
        }
    }
    
    func handleLogin(){
        
    }
    
    func signOut() {
        do {
            InviteManager.shared.handleLogout()
            try Auth.auth().signOut()
            
            self.isAuthenticated = false
            self.userId = nil
            
            EventManager.shared.events.removeAll()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
