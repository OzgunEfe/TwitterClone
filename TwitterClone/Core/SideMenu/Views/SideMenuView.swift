//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Circle()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4){
                    Text("Bruce Wayne")
                        .font(.subheadline)
                    
                    Text("@batman")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                UserStatsView()
                    .padding(.vertical)
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                
                if viewModel == .profile {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }

                } else if viewModel == .logout {
                    Button {
                        // Bu kodu AuthViewModel icerisinden cagiriyorum. Yukarida da @EnvironmentObject var authViewModel: AuthViewModel olarak import ettim.
                        authViewModel.signOut()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }

                } else {
                    SideMenuOptionRowView(viewModel: viewModel)
                }
                
            }
            Spacer()
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure it takes up the full available space
    }
}


#Preview {
    SideMenuView()
}
