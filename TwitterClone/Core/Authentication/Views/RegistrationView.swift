//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullName = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                AuthHeaderView(title1: "Get started.", title2: "Create your account")
                
                VStack(spacing: 40) {
                    CustomInputField(imageName: "envelope", placeHolderText: "Email", text: $email)
                    CustomInputField(imageName: "person", placeHolderText: "Username", text: $username)
                    CustomInputField(imageName: "person", placeHolderText: "Full name", text: $fullName)
                    CustomInputField(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                }
                .padding(32)
                
                Button {
                    viewModel.register(withEmail: email, password: password, fullname: fullName, username: username)
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                .padding(.top, 4)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.footnote)
                            .foregroundColor(Color(.systemBlue))
                        
                        Text("Sign In")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.bottom, 32)
            }
            .ignoresSafeArea()
            
            // Add this to handle navigation when didAuthenticateUser changes
            .navigationDestination(isPresented: $viewModel.didAuthenticateUser) {
                ProfilePhotoSelectorView()
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
}
