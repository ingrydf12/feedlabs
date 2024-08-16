//
//  HomeViewModel.swift
//  FeedLabs
//
//  Created by User on 09/08/24.
//

import Foundation

@Observable
class HomeViewModel {
    var userManager: UserManager = UserManager.shared
    var eventManager = EventManager.shared
    var selectedDate = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter
    }()
    
    func groupedEventsByHour() -> [String: [Event]] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let filteredEvents = eventManager.events.filter { event in
            guard let eventDate = event.date else { return false }
            return eventDate >= startOfDay && eventDate < endOfDay
        }
        
        // Ordenar eventos por timeStamp crescente
        let sortedEvents = filteredEvents.sorted { event1, event2 in
            guard let timeStamp1 = event1.date, let timeStamp2 = event2.date else { return false }
            return timeStamp1 < timeStamp2
        }

        // Agrupar os eventos por hora
        return Dictionary(grouping: sortedEvents) { event -> String in
            guard let date = event.date else { return "Unknown time" }
            return dateFormatter.string(from: date)
        }
    }
}
