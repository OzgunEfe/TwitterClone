//
//  SideMenuOptionRowView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack{
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.trailing, 5)
            
            Text(viewModel.title)
                .foregroundColor(.black)
                .font(.subheadline)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    SideMenuOptionRowView(viewModel: .profile)
}
