//
//  AddEvent.swift
//  testFireStorage
//
//  Created by João Pedro Borges on 25/07/24.
//

import SwiftUI

struct AddEvent: View {
    @State private var name: String = ""
    @State private var isPrivate: Bool = false
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var estimatedTime: Int = 0
    @State private var selectedParticipants: Set<String> = []

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
                Section(header: Text("Escopo")) {
                    Picker("Escolha uma opção", selection: $isPrivate) {
                        Text("Privado").tag(true)
                        Text("Público").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                Section(header: Text("Selecionar Participantes")) {
                    List(UserManager.shared.users) { user in
                        if UserManager.shared.user?.id != user.id {
                            HStack {
                                Text(user.name ?? "")
                                Spacer()
                                if selectedParticipants.contains(user.id ?? "") {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if selectedParticipants.contains(user.id ?? "") {
                                    selectedParticipants.remove(user.id ?? "")
                                } else {
                                    selectedParticipants.insert(user.id ?? "")
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    guard let userId = AuthManager.shared.userId else{return}
                    print(selectedParticipants)
                    let newEvent = Event(
                        isPrivate: isPrivate,
                        participants: Array(selectedParticipants) + [userId],
                        owners: [userId],
                        name: name,
                        description: description,
                        createdAt: Date(),
                        date: date,
                        estimatedTime: estimatedTime
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
