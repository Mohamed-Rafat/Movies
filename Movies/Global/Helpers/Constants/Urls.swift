//
//  Urls.swift
//  Movies
//
//  Created by MohamedRafat on 6/8/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

enum Urls {
    static let baseUrl = "http://159.65.95.5:3000/api/"
    
    case GetUser
    case CreateUser
    case AllMovies
    case FavMovies(userID: Int)
    case SetToFav(userID: Int, movieID: Int)
    case RemoveFromFav(userID: Int, movieID: Int)
    
    func getUrlStr()-> String{
        switch self {
        case .GetUser , .CreateUser:
            return "/users"
        case .AllMovies:
            return "/movies"
        case .FavMovies(userID: let id):
            return "/users/\(String(id))/movies"
        case .SetToFav(userID: let uID, movieID: let mID):
            return "/users/\(uID)/movies/\(mID)/favorite"
        case .RemoveFromFav(userID: let uID, movieID: let mID):
            return "/users/\(uID)/movies/\(mID)/unfavorite"
        }
    }
    
    func getUrl()->URL {
        return URL(string: self.getUrlStr())!
    }
    
    static func getBaseURL()->URL{
        return URL(string: Urls.baseUrl)!
    }
}
