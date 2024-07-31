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
    
    // Bu fonksiyon ile Firebase uzerinden tweetlere ulasiyorum
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
    
    // Bu fonkiyon ile yine Firebase uzerinden tweets'e gidiyorum ve uid'i yakaliyorum. Bu sayede sadece bu kullanicinin gonderdigi tweetleri yakaliyorum.
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }

}

extension TweetService {
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        // firestore ile firebase ulasiyorum. Sonrasinda "users" > uid > "user-likes" ile like'lara ulasiyorum.
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikeRef.document(tweetId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unLikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikeRef.document(tweetId).delete { _ in
                    completion()
                }
            }
    }
    
    // "users" data structure bolumune gidiyorum oradan "user-likes" colection'i kontrol ediyorum. Eger tweet id bu listede mevcut ise kullanicinin tweeti begendigini anliyorum.
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                // Buradaki .exists bilginin var olup olmadigina gore true ya da false donuyor.
                completion(snapshot.exists)
            }
        
    }
    
    // Bu fonksiyon ile begenilen tweetleri cekip profilde gosterecegim. uid kullanmamin nedeni bu uid'ye sahip kisinin begendigi tweetleri cekip gosterecegimiz icin Tweet'i liste olarak cekiyoruz.
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            
                            completion(tweets)
                        }
                }
            }
    }
}
