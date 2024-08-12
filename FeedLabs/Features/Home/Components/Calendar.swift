//
//  Calendar.swift
//  FeedLabs
//
//  Created by User on 09/08/24.
//

import SwiftUI

import SwiftUI

struct Calendar: View {
    @State var selectedDate = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }
    var body: some View{
        NavigationStack{
            VStack{
                DatePicker("Escolha uma data", selection: $selectedDate, displayedComponents: [.date])
                // deixar scroll e tirar os botoes
                //isso mostra o calendario no formato grande
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .environment(\.locale,Locale(identifier: "pt_BR"))
                    
       
                Text("Eventos do dia \(dateFormatter.string(from: selectedDate)):")
                
                   //se tiver evento aparecer
                
                   //se nao tiver nao aparece
            }
            Spacer()
            
          
        }
        
    }
        
}

//struct CalendarViewBody: View {
//    @Binding var selectedDate: Date
//    var calendar = Calendar(identifier: .gregorian)
//    var dateFormatter: DateFormatter{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d"
//        formatter.locale = Locale(identifier: "pt_BR")
//        return formatter
//    }
//    var daysInMonth: [Date] {
//            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
//            let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
//            return range.compactMap { day in
//                calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
//            }
//        }
//        
//        var startOfMonth: Date {
//            calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
//        }
//        
//        var firstDayOfMonth: Date {
//            let components = calendar.dateComponents([.year, .month], from: startOfMonth)
//            return calendar.date(from: components)!
//        }
//        
//        var days: [Date] {
//            var days: [Date] = []
//            let startOfWeek = calendar.component(.weekday, from: firstDayOfMonth)
//            for _ in 1..<startOfWeek {
//                days.append(Date())
//            }
//            days.append(contentsOf: daysInMonth)
//            return days
//        }
//        
//        var body: some View {
//            VStack {
//                HStack {
//                    Text("Dom")
//                    Text("Seg")
//                    Text("Ter")
//                    Text("Qua")
//                    Text("Qui")
//                    Text("Sex")
//                    Text("Sáb")
//                }
//                .font(.caption)
//                .padding()
//                
//                let columns = Array(repeating: GridItem(.flexible()), count: 7)
//                
//                LazyVGrid(columns: columns, spacing: 10) {
//                    ForEach(days, id: \.self) { date in
//                        Text(dateFormatter.string(from: date))
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .background(self.calendar.isDate(date, inSameDayAs: selectedDate) ? Color.blue : Color.clear)
//                            .foregroundColor(self.calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : Color.black)
//                            .onTapGesture {
//                                selectedDate = date
//                            }
//                    }
//                }
//            }
//        }
//    }
#Preview {
    Calendar()
}
