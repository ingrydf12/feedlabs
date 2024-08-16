//
//  EventsListView.swift
//  FeedLabs
//
//  Created by User on 12/08/24.
//

import SwiftUI

struct EventsListView: View {
    let groupedEvents: [String: [Event]]
    
    var body: some View {
        ScrollView(.vertical) {
            if groupedEvents.isEmpty {
                EmptyEventsView()
            } else {
                ForEach(groupedEvents.keys.sorted { Int($0)! < Int($1)!}, id: \.self) { hour in
                    VStack(alignment: .leading, spacing: 8) {
                        DividerComponent(text: "\(hour):00")
                        ForEach(groupedEvents[hour]!) { event in
                            
                            VStack {
                                Text("\(event.id!)")
                                Text("\(event.name!)")
                                Text("\(event.date!.formatted())")
                            }
                            .frame(maxWidth: .infinity , alignment: .center)
                            .padding()
                            .background {
                                
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke()
                            }
//                             EventRowView(event: event)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    EventsListView(groupedEvents: .init())
}
