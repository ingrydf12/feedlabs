//
//  UserManager.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import Foundation
import FirebaseFirestore

class UserManager: ObservableObject {
    
    static let shared = UserManager()
    
    @Published var user: User?
    @Published var users: [User] = []
    @Published var searchUsers: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = ""
    @Published var isSearchingUser: Bool = false{
        didSet {
            if self.searchText.count != 0 {
                self.filterUsersByEmail( email: searchText)
            }else {
                self.searchUsers.removeAll()
            }
        }
    }
    @Published var isLoading = false
    
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
    func addUser(user: User) {
       guard let userId = user.id else {
           print("User ID is missing")
           return
       }
       
       let db = Firestore.firestore()
       
       do {
           let _ = try db.collection("Users").document(userId).setData(from: user)
           print("User added successfully to Firestore")
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
    
    func filterUsers(){
        if !users.isEmpty{
            let userFilter = users.filter({
                return $0.id != AuthManager.shared.userId
            })
            self.filteredUsers = userFilter.sorted{ $0.email ?? "" < $1.email ?? ""}
        }
        
    }
    
    func filterUsersByEmail(email: String){
        guard !searchText.isEmpty else {
            self.searchUsers = []
            self.isLoading = false
            return
        }
        
        let userFilter = filteredUsers.filter({
            return $0.email!.contains( email)
        })
        self.searchUsers = userFilter
    }
}
