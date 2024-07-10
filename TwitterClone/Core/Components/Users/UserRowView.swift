//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct UserRowView: View {
    var body: some View {
        HStack(spacing: 10){
            Circle()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4){
                Text("Heath Ledger")
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                
                Text("@joker")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    UserRowView()
}
