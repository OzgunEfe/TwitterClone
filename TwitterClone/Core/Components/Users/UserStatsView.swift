//
//  UserStatsView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        
        HStack(spacing: 20){
            HStack(spacing: 6){
                Text("54")
                    .font(.subheadline)
                    .bold()
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 5){
                Text("125").bold()
                    .font(.subheadline)
                    .bold()
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    UserStatsView()
}
