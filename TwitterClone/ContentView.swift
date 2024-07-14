//
//  ContentView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if viewModel.userSession == nil {
            LoginView()
        } else {
            mainInterfaceView
        }

    }

}

extension ContentView {
    
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
            
            if showMenu {
                ZStack{
                    Color(.black)
                        .opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300, y:0 )
                
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                if let user = viewModel.currentUser {
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    } label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                }

            }
        }
        .onAppear {
            showMenu = false
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
