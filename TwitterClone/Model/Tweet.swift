//
//  Tweet.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 21/07/2024.
//

import Firebase
import FirebaseFirestore

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var user: User?
    var didLike: Bool? = false
}
