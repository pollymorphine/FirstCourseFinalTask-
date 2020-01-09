//
//  User.swift
//  FirstCourseFinalTask
//
//  Created by Polina on 08.01.2020.
//  Copyright © 2020 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

struct User: UserProtocol {
    
    var id: UserProtocol.Identifier
    
    var username: String
    
    var fullName: String
    
    var avatarURL: URL?
    
    var currentUserFollowsThisUser: Bool
    
    var currentUserIsFollowedByThisUser: Bool
    
    var followsCount: Int
    
    var followedByCount: Int
    
}


   

