//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 14/07/2024.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fecthUsers()
    }
    
    func fecthUsers() {
        service.fecthUsers { users in
            self.users = users
            
            print("DEBUG: Users are \(users)")
        }
    }
}
