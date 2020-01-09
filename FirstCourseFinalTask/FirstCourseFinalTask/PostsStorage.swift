//
//  PostsStorage.swift
//  FirstCourseFinalTask
//
//  Created by Polina on 08.01.2020.
//  Copyright © 2020 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

class PostsStorage: PostsStorageProtocol {
    
    var post: PostProtocol?
    var posts: [PostInitialData]
    var likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)]
    var currentUserID: GenericIdentifier<UserProtocol>
    var count: Int { posts.count }
   
    var newPost = Post(id: "",
                       author: "",
                       description: "",
                       currentUserLikesThisPost: false,
                       likedByCount: 0)
    
    
    
    required init(posts: [PostInitialData],
                  likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)],
                  currentUserID: GenericIdentifier<UserProtocol>) {
        
        self.posts = posts
        self.likes = likes
        self.currentUserID = currentUserID
    }
    
    func post(with postID: GenericIdentifier<PostProtocol>) -> PostProtocol? {
        
        guard posts.contains(where: {$0.id == postID}) else {
            return nil
        }
        
        var somePost = newPost
        
        for post in posts {
            if post.id == postID {
                somePost.id = post.id
                somePost.author = post.author
                somePost.description = post.description
                somePost.likedByCount = likes.filter{$0.1 == postID}.count
                
            }
        }
        
        for like in likes {
            
            if like.0 == currentUserID && like.1 == postID {
                somePost.currentUserLikesThisPost = true
            }
        }
        
        return somePost
    }
    
    //============================================================================
    
    func findPosts(by authorID: GenericIdentifier<UserProtocol>) -> [PostProtocol] {
        
        guard posts.contains(where: {$0.author == authorID}) else {
            return [PostProtocol]()
        }
        var postArray = newPost
        
        var postsArray = [Post]()
        
        for post in posts {
            if post.author == authorID {
                postArray.id = post.id
                postArray.author = post.author
                postArray.description = post.description
                
                postsArray.append(postArray)
            }
        }
        
        return postsArray
    }
    
    //============================================================================
    
    func findPosts(by searchString: String) -> [PostProtocol] {
        
        guard posts.contains(where: {$0.description == searchString}) else {
            return [PostProtocol]()
        }
        
        var foundPost = newPost
        
        for post in posts {
            if post.description == searchString {
                foundPost.id = post.id
            }
        }
        
        return [foundPost]
    }
    
    //============================================================================
    
    
    func likePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        
        guard posts.contains(where: {$0.id == postID}) else {
            return false
        }
        
        likes.append((currentUserID, postID))
        
        return true
    }
    
    //============================================================================
    
    
    func unlikePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        
        guard posts.contains(where: {$0.id == postID}) else {
            return false
        }
        
        likes.removeAll(where: { $0.0 == currentUserID && $0.1 == postID})
        
        return true
    }
    
    //============================================================================
    
    
    func usersLikedPost(with postID: GenericIdentifier<PostProtocol>) -> [GenericIdentifier<UserProtocol>]? {
        
        guard posts.contains(where: {$0.id == postID}) else {
            return nil
        }
        
        var somePost = newPost
        
        var usersArray = [GenericIdentifier<UserProtocol>]()
        
        
        for like in likes {
            if like.1 == postID {
                somePost.author = like.0
                usersArray.append(somePost.author)
            }
        }
        
        return usersArray
    }
    
}
