//
//  TextContentView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 01/07/2024.
//

import SwiftUI

struct TextContentView: View {
    @State private var showMenu = false

       var body: some View {
           NavigationView {
               ZStack(alignment: .topLeading) {
                   // Main view
                   MainTabView()
                       .navigationBarHidden(showMenu) // Hide navigation bar when menu is open
                       .navigationTitle(showMenu ? "" : "Home") // Hide title when menu is open
                       .navigationBarTitleDisplayMode(.inline)
                       .toolbar {
                           ToolbarItem(placement: .navigationBarLeading) {
                               if !showMenu { // Show the profile circle only when menu is closed
                                   Button(action: {
                                       withAnimation(.easeInOut) {
                                           showMenu.toggle()
                                       }
                                   }) {
                                       Circle()
                                           .frame(width: 32, height: 32)
                                   }
                               }
                           }
                       }
                       .disabled(showMenu) // Disable interactions with the main view when the menu is open

                   // Dimmed background
                   if showMenu {
                       Color.black.opacity(0.25)
                           .edgesIgnoringSafeArea(.all)
                           .onTapGesture {
                               withAnimation(.easeInOut) {
                                   showMenu = false
                               }
                           }
                   }

                   // Side menu
                   if showMenu {
                       SideMenuView()
                           .frame(width: 300)
                           .transition(.move(edge: .leading))
                   }
               }
               .onAppear {
                   showMenu = false
               }
           }
           .navigationViewStyle(StackNavigationViewStyle()) // Helps to avoid issues on iPad and macOS
       }
}

#Preview {
    TextContentView()
}
