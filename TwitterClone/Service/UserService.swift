//
//  UserService.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 14/07/2024.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    // Bu kod sayesinde firebase'den login olan kullanici bilgilerini aliyorum.
    func fecthUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
    // Bu kod ile diger tum kullanicilarin bilgilerini aliyorum.
    // Burada @escaping([User]) koseli parantez kullandim cunku datalari array olarak alacagim.
    func fecthUsers(completion: @escaping([User]) -> Void) {
       // var users = [User]() kodu da documents.forEach ile kullanildigi icin yoruma aldim.
//        var users = [User]()
        
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                // Asagidaki documents.forEach kodu yerine bu kodu da kullanabiliriz daha kisa versiyonu.
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                
                
//                documents.forEach { document in
//                    guard let user = try? document.data(as: User.self) else { return }
//                    users.append(user)
//                }
                
                completion(users)
            }
    }
    
}
