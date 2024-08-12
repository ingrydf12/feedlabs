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
    //@State private var estimatedTime: Int = 0
    @State private var selectedParticipants: Set<String> = []
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            //MARK: Event Details
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Insira o título do evento", text: $name)
                        .autocapitalization(.none)
                    TextField("Insira uma breve descrição", text: $description)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Event Date and Time")) {
                    DatePicker("Dia", selection: $date, displayedComponents: [.date])
                    DatePicker("Horário", selection: $date, displayedComponents: [.hourAndMinute])
                }
                
                Section(header: Text("Tipo de Evento")) {
                    Picker("Escolha uma opção", selection: $isPrivate) {
                        Text("Privado").tag(true)
                        Text("Público").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                //MARK: Add participants
                Section(header: Text("Selecionar Participantes")) {
                    List(UserManager.shared.users) { user in
                        if UserManager.shared.user?.id != user.id {
                            HStack {
                                Text(user.name ?? "")
                                Spacer()
                                if selectedParticipants.contains(user.id ?? "") {
                                    // Value: Selected
                                    Image(systemName: "person.fill.checkmark")
                                        .foregroundStyle(Color.blue)
                                        .background(Circle().fill(Color.cyan.opacity(0.2))
                                            .frame(width: 43, height: 43))
                                } else {
                                    //Value: Default
                                    Image(systemName: "person.badge.plus")
                                        .foregroundColor(.cyan)
                                        .background(Circle().fill(Color.cyan.opacity(0.2))
                                            .frame(width: 43, height: 43))
                                }
                            }
                            .contentShape(Rectangle())
                            .frame(height: 48)
                            .onTapGesture {
                                if selectedParticipants.contains(user.id ?? "") {
                                    selectedParticipants.remove(user.id ?? "")
                                } else {
                                    selectedParticipants.insert(user.id ?? "")
                                }
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
                
                //MARK: Action Button
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
                        date: date
                    )
                    EventManager.shared.addEvent(newEvent)
                    //presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Criar evento")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(PrimaryButton())
            }
            .navigationTitle("Criar evento")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
            })

        }
    }
}

#Preview {
    AddEvent()
}
