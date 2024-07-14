//
//  UserService.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 14/07/2024.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    // Bu kod sayesinde firebase'den login olan kullanici bilgilerini aliyoruz.
    func fecthUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
}
