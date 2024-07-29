//
//  AddEvent.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI

struct AddEvent: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var estimatedTime: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Name", text: $name)
                        .autocapitalization(.none)
                    TextField("Description", text: $description)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Event Date and Time")) {
                    DatePicker("Dia", selection: $date, displayedComponents: [.date])
                    DatePicker("Horário", selection: $date, displayedComponents: [.hourAndMinute])
                }
                
                Section(header: Text("Tempo Estimado")) {
                    Stepper(value: $estimatedTime, in: 0...320, step: 5) {
                        Text("Tempo Estimado: \(estimatedTime) minutos")
                    }
                }
                
                Button(action: {
                    guard let userId = AuthManager.shared.userId else{return}
                    
                    let newEvent = Event(
                        name: name,
                        description: description,
                        createdAt: Date(),
                        date: date,
                        estimatedTime: estimatedTime,
                        participants: [userId],
                        owners: [userId]
                    )
                    EventManager.shared.addEvent(newEvent)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Event")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Add Event")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    AddEvent()
}
