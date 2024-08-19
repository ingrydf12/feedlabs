//
//  SearchViewModel.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 18/08/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    var searchUsers: [User] = []
    var filteredUsers: [User] = []
    var searchText: String = ""
    var isSearchingUser: Bool = false{
        didSet {
            if self.searchText.count != 0 {
                self.filterUsersByEmail( name: searchText)
            }else {
                self.searchUsers.removeAll()
            }
        }
    }
    var isLoading = false
    
    
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
