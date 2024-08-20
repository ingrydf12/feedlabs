import SwiftUI

struct ParticipantsList: View {
    
    @Binding var selectedParticipants: Set<String>
    @Binding var type: EventType
    var userManager = UserManager.shared
    var teams = TeamsViewModel.shared.teams
    
    var body: some View {
        
        if type == .talk {
            // Display message for talk type
            HStack(alignment:.center){
                VStack{
                    Image("sucess_reset")
                        .resizable()
                        .frame(width: 110,height: 120)
                    Text("Todos os usuários podem participar!")
                        .font(.system(size: 16, weight: .semibold))
                }.padding()
            }.frame(maxWidth: .infinity)
        }else if type == .teamMeet {
            // Display teams for teamMeet type
            ForEach(teams) { team in
                HStack {
                    Text(team.name)
                    Spacer()
                    if team.participants?.allSatisfy({ selectedParticipants.contains($0) }) ?? false {
                        // Value: Selected
                        Image(systemName: "person.fill.checkmark")
                            .foregroundStyle(.accent)
                            .background(Circle().fill(.accent.opacity(0.2))
                                .frame(width: 43, height: 43))
                    } else {
                        // Value: Default
                        Image(systemName: "person.badge.plus")
                            .foregroundStyle(.accent)
                            .background(Circle().fill(.accent.opacity(0.2))
                                .frame(width: 43, height: 43))
                    }
                }
                .padding(.trailing)
                .contentShape(Rectangle())
                .frame(height: 48)
                .onTapGesture {
                    if let teamParticipants = team.participants {
                        selectedParticipants = Set(teamParticipants)
                    }
                }
            }
        } else {
            // Display participants list for other event types
            ForEach(userManager.users) { user in
                if userManager.user?.id != user.id {
                    HStack {
                        Text(user.name ?? "")
                        Spacer()
                        if selectedParticipants.contains(user.id ?? "") {
                            // Value: Selected
                            Image(systemName: "person.fill.checkmark")
                                .foregroundStyle(.accent)
                                .background(Circle().fill(.accent.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        } else {
                            //Value: Default
                            Image(systemName: "person.badge.plus")
                                .foregroundStyle(.accent)
                                .background(Circle().fill(.accent.opacity(0.2))
                                    .frame(width: 43, height: 43))
                        }
                    }
                    .padding(.trailing)
                    .contentShape(Rectangle())
                    .frame(height: 48)
                    .onTapGesture {
                        if type == .oneOnOne {
                            // Ensure only one participant is selected
                            selectedParticipants = [user.id ?? ""]
                        } else {
                            // Handle selection for other event types
                            if selectedParticipants.contains(user.id ?? "") {
                                selectedParticipants.remove(user.id ?? "")
                            } else {
                                selectedParticipants.insert(user.id ?? "")
                            }
                        }
                    }
                }
            }
        }
    }
}
