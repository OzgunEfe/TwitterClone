//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 09/07/2024.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Setup account,",
                           title2: "add a profile photo.")
            
            Button {
                showImagePicker.toggle()
            } label: {
                VStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .frame(width: 120, height: 120)
                        .padding(.top, 140)
                        .padding(.bottom, 10)
                    
                    Text("Add Photo")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
            }

            
            Spacer()
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    ProfilePhotoSelectorView()
}
