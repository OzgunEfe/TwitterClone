//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 14/07/2024.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        // Burada searchbar text kontrolu yapiyorum. Eger text alani bossa kullanicilari gosteriyorum.
        if searchText.isEmpty {
            return users
        // Eger kullanici bir sey yazmissa buna gore search ozelligini calistiyorum.
        } else {
            let lowercasedQuary = searchText.lowercased()
            
            return users.filter( {
                $0.username.contains(lowercasedQuary) ||
                $0.fullname.lowercased().contains(lowercasedQuary)
            })
        }
    }
    
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
