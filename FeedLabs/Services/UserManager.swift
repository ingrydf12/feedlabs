//
//  UserManager.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

@Observable
final class UserManager {
    
    static let shared = UserManager()
    
    var user: User?
    
    var users: [User] = []
    var searchUsers: [User] = []
    var filteredUsers: [User] = []
    var searchText: String = ""
    var isSearchingUser: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                self.filterUsersByEmail(name: searchText)
            } else {
                self.searchUsers.removeAll()
            }
        }
    }
    var isLoading = false
    
    private init () {
        print("init User Manager")
        getUsers()
        
    }
    
    func fetchUser() {
        print("feching user")
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
                NotificationCenter.default.post(name: NSNotification.Name("UserUpdated"), object: nil)
            }
        }
    }
    func getUsers(){
        print("getting users")
        guard AuthManager.shared.userId != nil else { return }
        
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
               
                self.filterUsers()
                print("Users fetched successfully")
            }
            
        }
    }
    
    func getUserById(_ userId: String) -> User? {
        if userId == user?.id {
            return user
        }
        return users.first(where: { $0.id == userId })
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
    func deleteLoggedInUser() {
        guard let user = Auth.auth().currentUser else {
            print("No user is currently logged in")
            return
        }
        
        let userId = user.uid
        let firestore = Firestore.firestore()
        let realtimeDatabase = Database.database().reference()
        
        // Deletar usuário do Firestore
        firestore.collection("Users").document(userId).delete { error in
            if let error = error {
                print("Error deleting user from Firestore: \(error.localizedDescription)")
            } else {
                print("User successfully deleted from Firestore")
                
                // Deletar usuário do Realtime Database
                realtimeDatabase.child("users/\(userId)").removeValue { error, _ in
                    if let error = error {
                        print("Error deleting user from Realtime Database: \(error.localizedDescription)")
                    } else {
                        print("User successfully deleted from Realtime Database")
                        
                        // Deletar a conta de autenticação do usuário
                        user.delete { error in
                            if let error = error {
                                print("Error deleting user authentication: \(error.localizedDescription)")
                            } else {
                                print("User authentication successfully deleted")
                                AuthManager.shared.signOut()
                            }
                        }
                    }
                }
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
    
    func filterUsers(){
        if !users.isEmpty{
            let userFilter = users.filter({
                return $0.id != AuthManager.shared.userId
            })
            self.filteredUsers = userFilter.sorted{ $0.name?.uppercased() ?? "" < $1.name?.uppercased() ?? ""}
        }
    }
    
    func filterUsersByName(name: String){
        guard !searchText.isEmpty else {
            self.searchUsers = []
            self.isLoading = false
            return
        }
        
        let userFilter = filteredUsers.filter({
            return ($0.name ?? "").uppercased().contains(name.uppercased())
        })
        self.searchUsers = userFilter
    }
    
    func checkIfEmailExists(email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        
        ref.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error checking email existence: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let snapshot = snapshot, !snapshot.isEmpty {
                // O email já existe no banco de dados
                completion(true)
            } else {
                // O email não existe no banco de dados
                completion(false)
            }
        }
    }
    
    func filterUsersByEmail(name: String){
        guard !searchText.isEmpty else {
            self.searchUsers = []
            self.isLoading = false
            return
        }
        
        let userFilter = filteredUsers.filter({
            return $0.name!.uppercased().contains(name.uppercased())
        })
        self.searchUsers = userFilter
    }
}
