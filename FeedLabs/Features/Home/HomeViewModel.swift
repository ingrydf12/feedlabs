//
//  HomeViewModel.swift
//  FeedLabs
//
//  Created by User on 09/08/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    var userManager: UserManager = UserManager.shared
    var eventManager: EventManager = EventManager.shared

}
