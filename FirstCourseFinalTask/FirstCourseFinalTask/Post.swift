//
//  Post.swift
//  FirstCourseFinalTask
//
//  Created by Polina on 08.01.2020.
//  Copyright © 2020 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

struct  Post: PostProtocol {

      var id: Self.Identifier
      
      var author: GenericIdentifier<UserProtocol>
      
      var description: String
      
      var imageURL: URL { return .init(fileURLWithPath: "") }
      
      var createdTime: Date { return .init() }
      
      var currentUserLikesThisPost: Bool
      
      var likedByCount: Int
    

    init (id: String, author: String, description: String, currentUserLikesThisPost: Bool, likedByCount: Int ) {
    self.id = Post.Identifier(rawValue: id)
    self.author = GenericIdentifier<UserProtocol>(rawValue: author)
    self.description = description
    self.currentUserLikesThisPost =  currentUserLikesThisPost
    self.likedByCount = likedByCount
}
 
}

