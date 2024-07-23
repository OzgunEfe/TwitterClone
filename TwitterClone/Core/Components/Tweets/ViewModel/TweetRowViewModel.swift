//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 23/07/2024.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    private let service = TweetService()
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
}
