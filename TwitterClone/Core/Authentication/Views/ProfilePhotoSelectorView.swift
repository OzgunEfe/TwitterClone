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
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Setup account,",
                           title2: "add a profile photo.")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .padding(.top, 120)
                        .padding(.bottom, 10)
                        
                } else {
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
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            // Burasi profil fotografi yukledikten sonra devam butonu cikirtiyor.
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                .padding(.top, 4)
            }

            
            Spacer()
        }
        .ignoresSafeArea()
        
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}


#Preview {
    ProfilePhotoSelectorView()
}
