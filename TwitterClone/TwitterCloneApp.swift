//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
