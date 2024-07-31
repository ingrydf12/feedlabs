//
//  UserManager.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

class UserManager: ObservableObject {
    
    static let shared = UserManager()
    
    @Published var user: User?
    @Published var users: [User] = []
    
    private init () {
        print("init User Manager")
        fetchUser()
        getUsers()
    }
    
    func fetchUser() {
        guard let userId = AuthManager.shared.userId else { return }
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userId)
        
        ref.getDocument { document, error in
            if let error = error {
                print("error:", error.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                self.user = try? document.data(as: User.self)
            }
        }
    }
    func getUsers(){
        guard let userId = AuthManager.shared.userId else { return }
        
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                print("error:", error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self.users = snapshot.documents.compactMap { document in
                    try? document.data(as: User.self)
                }
                print("Users fetched successfully")
            }
            
        }
    }
    func addUser(user: User) {
       guard let userId = user.id else {
           print("User ID is missing")
           return
       }
       
       let db = Firestore.firestore()
       
       do {
           try db.collection("Users").document(userId).setData(from: user) { error in
               if let error = error {
                   print("Error adding user to Firestore: \(error.localizedDescription)")
               } else {
                   print("User added successfully to Firestore")
                
                   let ref = Database.database().reference()
                   ref.child("users/\(userId)").setValue(["exists": true]) { error, _ in
                       if let error = error {
                           print("Error adding user ID to Realtime Database: \(error.localizedDescription)")
                       } else {
                           print("User ID added successfully to Realtime Database")
                       }
                   }
               }
           }
       } catch let error {
           print("Error adding user to Firestore: \(error.localizedDescription)")
       }
    }
    func deleteUser(userId: String) {
       let db = Firestore.firestore()
       
       db.collection("Users").document(userId).delete { error in
           if let error = error {
               print("Error deleting user: \(error.localizedDescription)")
           } else {
               print("User deleted successfully")
           }
       }
    }
    func editUser(user: User) {
        guard let userId = user.id else {
            print("User ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        do {
            let _ = try db.collection("Users").document(userId).setData(from: user, merge: true)
            print("User edited successfully")
        } catch let error {
            print("Error editing user: \(error.localizedDescription)")
        }
    }

}
