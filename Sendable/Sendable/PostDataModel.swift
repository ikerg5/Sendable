//
//  PostDataModel.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/19/25.
//

import UIKit

// MARK: - Post Data Model
struct Post: Codable {
    let id: UUID
    let imageData: Data
    let level: String
    let notes: String
    let attempts: Int
    let dateCreated: Date
    let username: String
    
    init(image: UIImage, level: String, notes: String, attempts: Int, username: String = "Anonymous") {
        self.id = UUID()
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
        self.level = level
        self.notes = notes
        self.attempts = attempts
        self.dateCreated = Date()
        self.username = username
    }
    
    var image: UIImage? {
        return UIImage(data: imageData)
    }
}

// MARK: - Data Manager
class PostDataManager {
    static let shared = PostDataManager()
    
    private let feedPostsKey = "FeedPosts"
    private let savedPostsKey = "SavedPosts"
    
    private init() {}
    
    // Save to Feed
    func saveFeedPost(_ post: Post) {
        var feedPosts = getFeedPosts()
        feedPosts.append(post)
        savePosts(feedPosts, key: feedPostsKey)
    }
    
    // Save to Profile (Saved Posts)
    func saveSavedPost(_ post: Post) {
        var savedPosts = getSavedPosts()
        savedPosts.append(post)
        savePosts(savedPosts, key: savedPostsKey)
    }
    
    // Get Feed Posts
    func getFeedPosts() -> [Post] {
        return getPosts(key: feedPostsKey)
    }
    
    // Get Saved Posts
    func getSavedPosts() -> [Post] {
        return getPosts(key: savedPostsKey)
    }
    
    // Delete a feed post
    func deleteFeedPost(at index: Int) {
        var feedPosts = getFeedPosts()
        guard index < feedPosts.count else { return }
        feedPosts.remove(at: index)
        savePosts(feedPosts, key: feedPostsKey)
    }
    
    // Delete a saved post
    func deleteSavedPost(at index: Int) {
        var savedPosts = getSavedPosts()
        guard index < savedPosts.count else { return }
        savedPosts.remove(at: index)
        savePosts(savedPosts, key: savedPostsKey)
    }
    
    // Private helper methods
    private func savePosts(_ posts: [Post], key: String) {
        if let encoded = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func getPosts(key: String) -> [Post] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            return []
        }
        return posts
    }
}