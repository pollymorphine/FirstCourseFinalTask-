//
//  UserStorage.swift
//  FirstCourseFinalTask
//
//  Created by Polina on 08.01.2020.
//  Copyright © 2020 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

class UserStorage: UsersStorageProtocol {
    
    var currentUserID: GenericIdentifier<UserProtocol>
    var count: Int { users.count }
    var users: [UserInitialData]
    var followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
    var newUser: User
    
    
    required init?(users: [UserInitialData],
                   followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                   currentUserID: GenericIdentifier<UserProtocol>) {
        
        guard users.contains(where: {$0.id == currentUserID}) else {
            return nil
        }
        
        self.currentUserID = currentUserID
        self.followers = followers
        self.users = users
        let userStruc = User(id: currentUserID,
                             username: "",
                             fullName: "",
                             avatarURL: nil,
                             currentUserFollowsThisUser: false,
                             currentUserIsFollowedByThisUser: false,
                             followsCount: 0,
                             followedByCount: 0)
        self.newUser = userStruc
        
    }
    
    //============================================================================
    
    func currentUser() -> UserProtocol {
        var currentUser = newUser
        
        
        for user in users {
            if user.id == currentUserID {
                currentUser.id = user.id
                currentUser.username = user.username
            }
        }
        
        for follower in followers {
            
            if follower.0 == currentUserID {
                currentUser.followsCount += 1
            } else if follower.1 == currentUserID {
                currentUser.followedByCount += 1
            }
        } 
        
        
        return currentUser
    }
    
   //============================================================================
    
    func user(with userID: GenericIdentifier<UserProtocol>) -> UserProtocol? {
        
        guard users.contains(where: {$0.id == userID}) else {
            return nil
        }
        
        var user = newUser
        
        for someUser in users {
            if someUser.id == userID {
                user.id = someUser.id
                user.username = someUser.username
            }
        }
        
        for follower in followers {
            
            if follower.0 == userID {
                user.followsCount += 1
                user.currentUserFollowsThisUser = true
            } else if follower.1 == userID {
                user.followedByCount += 1
                user.currentUserIsFollowedByThisUser = true
            }
        }
        return user
    }
    
    //============================================================================
    
    func findUsers(by searchString: String) -> [UserProtocol] {
        
        guard users.contains(where: {$0.username == searchString}) else {
            return [UserProtocol]()
        }
        
        var foundUser = newUser
        
        for user in users {
            if user.username == searchString {
                foundUser.id = user.id
                foundUser.username = user.username
                foundUser.fullName = user.fullName
            }
        }
        return [foundUser]
    }
    
    //============================================================================
    
    
    func follow(_ userIDToFollow: GenericIdentifier<UserProtocol>) -> Bool {
        
        guard users.contains(where: {$0.id == userIDToFollow}) else {
            return false
        }
        
        followers.append((currentUserID, userIDToFollow))
        
        return true
    }
    
    //============================================================================
    
    func unfollow(_ userIDToUnfollow: GenericIdentifier<UserProtocol>) -> Bool {
        
        guard users.contains(where: {$0.id == userIDToUnfollow}) else {
            return false
        }
        
        followers.removeAll(where: { $0.0 == currentUserID && $0.1 == userIDToUnfollow})
        
        return true
    }
    
    //============================================================================
    
    func usersFollowingUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        
        guard users.contains(where: {$0.id == userID}) else {
            return nil
        }
        
        var follower = newUser
        
        var followersArray = [UserProtocol]()
        
        for user in followers {
            if user.1 == userID {
                follower.id = user.0
                followersArray.append(follower)
                
            }
        }
        
        return followersArray
    }
    
    //============================================================================
    
    func usersFollowedByUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        
        guard users.contains(where: {$0.id == userID}) else {
            return nil
        }
        
        var following = newUser
        
        var followingArray = [UserProtocol]()
        
        for user in followers {
            if user.0 == userID {
                following.id = user.1
                followingArray.append(following)
            }
        }
        
        return followingArray
    }
    
}
