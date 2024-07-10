//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack(alignment: .leading){
            // Profile img + user info + tweet
            HStack(alignment: .top, spacing: 12){
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(Color(.systemBlue))
                
                // User info + tweet caption
                VStack(alignment: .leading, spacing: 5){
                    // User info
                    HStack{
                        Text("Bruce Wayne")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Text("@batman")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text("2w")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    // Tweet caption
                    Text("I am Batman. hahahhaa skdjnfkajsnlksdd ksjndfkjnaskjfnsdklj skjdfnaksdjnflkajsd dslkjfnalksnflkjasdn.")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 15)
                    
                    // Action buttons
                    HStack{
                        Button {
                            //action happens here
                        } label: {
                            Image(systemName: "bubble.left")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            //action happens here
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            //action happens here
                        } label: {
                            Image(systemName: "heart")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            //action happens here
                        } label: {
                            Image(systemName: "bookmark")
                                .font(.subheadline)
                                .padding(.trailing, 10)
                        }

                    }
                    .foregroundColor(.gray)
                    
                }

            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 5)
            .padding(.top, 6)
            
            Divider()
        }
        
    }
}

#Preview {
    TweetRowView()
}
