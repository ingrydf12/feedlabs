//
//  ChatsView.swift
//  FeedLabs
//
//  Created by João Pedro Borges on 05/08/24.
//

import SwiftUI

struct ChatsView: View {
    @State var user: User?
    @State var message: String = ""
    @Environment(\.presentationMode) var presentationMode  
    
    var body: some View {
       
        NavigationStack{
            VStack{
                ScrollView{
                    VStack(alignment: .trailing){
                        HStack{
                            Spacer()
                            Text("ddd")
                                .frame(alignment: .trailing)
                                .padding()
                                .background(Color(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color("darkAqua"), lineWidth: 2)
                                )
                        }
                    }.padding()
                }
                Spacer()
                VStack{
                    HStack{
                        HStack{
                            TextField( "message", text: $message)
                                .padding()
                                .font(.callout)
                                
                            Button(action: {
                             
                            }, label: {
                               Image(systemName: "paperclip")
                                   .foregroundColor(Color("darkAqua"))
                            }).padding()
                               
                                .cornerRadius(30)
                        }.background(Color(.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("darkAqua"), lineWidth: 2)
                        )
                        
                        Button(action: {
                          
                        }, label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color("darkAqua") )
                        })
                        .padding()
                        .background(Color("lightAqua"))
                        .cornerRadius(30)
                    }
                    .font(.title2)
                }.padding()
                .padding(.top)
                .background(Color("backgroudTextField"))
            
            }
            .navigationTitle(user?.name ?? "Lucas")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {presentationMode.wrappedValue.dismiss()}){
                      
                        Image(systemName:  "chevron.backward").padding(-4)
                        Text("Voltar")
                    }.foregroundStyle(Color("darkAqua"))
                        .font(.headline)
                }
                
            }
            .toolbarBackground(Color("backgroudTextField"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
           
        }.navigationBarBackButtonHidden(true)
           
    }
    
   
}

#Preview {
    ChatsView()
}
