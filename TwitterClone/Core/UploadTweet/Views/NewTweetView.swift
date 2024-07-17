//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    
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
                    viewModel.uploadTweet(withCaption: caption)
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
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TextArea("What's happening?", text: $caption)
                    .padding(.leading, 12)
                
            }
            .padding()
        }
        // Bu kod ile yeni tweet'in upload edilip edilmedigine bakip aksiyon aliyorum.
        .onReceive(viewModel.$didUploadTweet) { success in
            if success {
                // tweet'in database'e upload'i basarili ise dismiss edip ekrani kapatiyorum.
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        Spacer()
    }
}

#Preview {
    NewTweetView()
}
