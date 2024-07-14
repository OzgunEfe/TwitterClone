//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {

            VStack{
                ScrollView {
                    LazyVStack{
                        ForEach(0 ... 25, id: \.self) { _ in
                            NavigationLink {
//                                ProfileView()
                            } label: {
                                UserRowView()
                            }

                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    ExploreView()
}
