//
//  Calendar.swift
//  FeedLabs
//
//  Created by User on 09/08/24.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }
    
    var body: some View {
        VStack {
            DatePicker("Escolha uma data", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .environment(\.locale, Locale(identifier: "pt_BR"))
                .background(Color(uiColor: .tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20.0))

            Text("Eventos do dia \(dateFormatter.string(from: selectedDate)):")
        }
        .padding(.top, 12)
    }
}

//#Preview {
//    CalendarView(selectedDate: Date())
//}
