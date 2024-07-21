//
//  TweetService.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 17/07/2024.
//

import Firebase

struct TweetService {
    // Burada yazdigim "completion: @escaping(Bool) -> Void" kodu tweet atildiktan sonra tweet atma ekranini kapatmak icin.
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        // Bu kod ile current user id'i aliyorum. Tweet'i kimin attigni bu sekilde data base'e kaydedecegiz.
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Faild to upload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    
                    return
                }
                
                completion(true)
            }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            // .order kodu ile Tweetleri tarihe gore siraladim
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets)
        }
    }
}
