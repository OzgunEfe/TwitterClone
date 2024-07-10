//
//  LoginView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                // header view
                // Components>Authentication altinda yazdim bu kodu. Oradan cagiriyorum.
                AuthHeaderView(title1: "Hello!", title2: "Welcome back")
                
                VStack(spacing: 40){
                    // Bu costum input alanlarini components altinda yazdim, oradan cagiriyorum.
                    CustomInputField(imageName: "envelope", placeHolderText: "Email", text: $email)
                    
                    CustomInputField(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                    
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                HStack{
                    Spacer()
                    
                    NavigationLink {
                        Text("Reset Password view...")
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                            .padding(.top)
                            .padding(.trailing, 24)
                    }

                }
                .padding(.top)
                
                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
                .padding(.top, 12)

                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarHidden(true)
                } label: {
                    HStack{
                        Text("Don't have an account")
                            .font(.footnote)
                            .foregroundColor(Color(.systemBlue))
                        
                        Text("Sign Up")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.bottom, 32)

            }
            .ignoresSafeArea()
        .navigationBarHidden(true)
        }
        
    }
}

#Preview {
    LoginView()
}
