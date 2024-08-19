import SwiftUI

struct AddEventView: View {
    
    @StateObject var viewModel = AddEventViewModel()
    @State var userManager = UserManager.shared
    @State private var showConfirmEvent = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Navigation Back Button and Title
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Criar evento")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }.scrollDisabled(true)
                .padding(.horizontal)
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing: 20) {
                        // Event Name and Description
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Nome")
                            TextField("Insira o nome do evento", text: $viewModel.name)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                            Text("Descrição")
                            TextField("Insira uma descrição sobre o evento", text: $viewModel.description)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        
                        // Date and Time Pickers
                        HStack {
                            Text("Data")
                            Spacer()
                            DatePicker("Jun 10, 2024", selection: $viewModel.date, displayedComponents: [.date])
                                .labelsHidden()
                                .datePickerStyle(CompactDatePickerStyle())
                            
                            DatePicker("9:41 AM", selection: $viewModel.date, displayedComponents: [.hourAndMinute])
                                .labelsHidden()
                                .datePickerStyle(CompactDatePickerStyle())
                        }
                        .padding(.horizontal)
                        
                        // Event Type Picker
                        HStack {
                            Text("Tipo de evento")
                                .foregroundColor(.black)
                            Spacer()
                            Picker("Escolha uma opção", selection: $viewModel.type) {
                                ForEach(EventType.allCases, id: \.self) { eventType in
                                    Text(eventType.rawValue)
                                        .font(.system(size: 18,weight: .bold))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // Participants Section
                        ParticipantsList(selectedParticipants: $viewModel.selectedParticipants, type: $viewModel.type)
                            .padding(.horizontal)
                    }
                }
                // Create Event Button
                Button("Criar Evento"){
                    viewModel.inviteParticipants()
                    showConfirmEvent = true
                    
                }.buttonStyle(PrimaryButton())
                .padding(.horizontal)
                .sheet(isPresented: $showConfirmEvent) {
                    ConfirmEvent()
                }

            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AddEventView()
}
