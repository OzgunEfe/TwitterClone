//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Button {
                    // cancel buton bu kod ile calisiyor.
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    print("Tweet")
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(Color(.white))
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                }

            }
            .padding()
            
            HStack(alignment: .top){
                Circle()
                    .frame(width: 64, height: 64)
                
                TextArea("What's happening?", text: $caption)
                    .padding(.leading, 12)
                
            }
            .padding()
        }
        
        Spacer()
    }
}

#Preview {
    NewTweetView()
}
