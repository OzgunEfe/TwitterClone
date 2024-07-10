//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case list
    case bookmarks
    case logout
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .list: return "List"
        case .bookmarks: return "Bookmarks"
        case .logout: return "Logout"
        }
    }
    
    // Bu section'da icon kullanacagimiz icin bu image bolumu yapiyoruz.
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .list: return "list.bullet"
        case .bookmarks: return "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
