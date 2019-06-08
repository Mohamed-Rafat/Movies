//
//  LocalCache.swift
//  Movies
//
//  Created by MohamedRafat on 6/8/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

class LocalCache{
    
    func setUser(user: User?, _ compeletion: ((Bool)->())? = nil) {
        try? UserDefaults.standard.set(object: user, for: "user") { (isSaved) in
           compeletion?(isSaved)
        }
    }
    
    func getUser(_ completion: @escaping (User?)->()){
        UserDefaults.standard.get(object: User.self, for: "user") { (user) in
           completion(user)
        }
    }
    
}
