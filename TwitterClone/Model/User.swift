//
//  User.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 14/07/2024.
//

import FirebaseFirestoreSwift
import Firebase

// Burada @DocumentID'i string olarak id degiskenine atiyoruz. Firebase uzerinde her kullanici icin farkli @DocumentID var.
struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id}
}
