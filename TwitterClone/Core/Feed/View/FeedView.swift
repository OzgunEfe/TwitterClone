//
//  FeedView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(0 ... 20, id: \.self) { _ in
                        TweetRowView()
                    }
                }
            }
            
            Button {
                showNewTweetView.toggle()
            } label: {
                Image("newTweetButton")
                    .resizable()
                    .frame(width: 72, height: 72)
            }
            .padding()
            // Bu kod ile showNewTweetView'i bu buton'a atiyoruz. isPresented true oldugunda yeni sayfamiz aciliyor.
            .fullScreenCover(isPresented: $showNewTweetView, content: {
                NewTweetView()
            })

        }
    }
}

#Preview {
    FeedView()
}
 
