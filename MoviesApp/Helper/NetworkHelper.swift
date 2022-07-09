//
//  NetworkHelper.swift
//  MadeInKuwait
//
//  Created by Amir on 3/14/20.
//  Copyright © 2020 Amir. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    //MARK:- SAVE USER DATA
    var movieName:String?{
        set{self.movieName = newValue}
        get{return self.movieName}
    }
    
    var selectedMovies:[Movie_M]?{
        set{self.selectedMovies = newValue}
        get{return self.selectedMovies}
    }
    
     var name: String?{
        didSet{
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
     var userID: Int?{
        didSet{
            UserDefaults.standard.set(userID, forKey: "userID")
        }
    }
    
     var selectedMovieID: Int?{
        didSet{
            UserDefaults.standard.set(selectedMovieID, forKey: "selectedMovieID")
        }
    }
    
     var phone: String?{
        didSet{
            UserDefaults.standard.set(phone, forKey: "phone")
        }
        
    }
    
     var avatar: String?{
        didSet{
            UserDefaults.standard.set(avatar, forKey: "avatar")
        }
    }
    
    //MARK:- GET USER DATA
     func getName() -> String? {
        if let name = UserDefaults.standard.value(forKey: "name") as? String{
            NetworkHelper.shared.name = name
        }
        return NetworkHelper.shared.name
    }
    
     func getSelectedMovieID() -> Int? {
        if let selectedMovieID = UserDefaults.standard.value(forKey: "selectedMovieID") as? Int{
            NetworkHelper.shared.selectedMovieID = selectedMovieID
        }
        return NetworkHelper.shared.selectedMovieID
    }
    
     func getUserId() -> Int? {
        if let userID = UserDefaults.standard.value(forKey: "userID") as? Int{
            NetworkHelper.shared.userID = userID
        }
        return NetworkHelper.shared.userID
    }
    
    
     func getPhone() -> String? {
        if let phone = UserDefaults.standard.value(forKey: "phone") as? String{
            NetworkHelper.shared.phone = phone
        }
        return NetworkHelper.shared.phone
    }
    
     func getAvatar() -> String? {
        if let avatar = UserDefaults.standard.value(forKey: "avatar") as? String{
            NetworkHelper.shared.avatar = avatar
        }
        return NetworkHelper.shared.avatar
    }
    
    
    
     func userLogout() {
        UserDefaults.standard.set(nil, forKey: "Logged")
        NetworkHelper.shared.name = nil
        UserDefaults.standard.removeObject(forKey: "name")
        NetworkHelper.shared.userID = nil
        UserDefaults.standard.removeObject(forKey: "userID")
        NetworkHelper.shared.phone = nil
        UserDefaults.standard.removeObject(forKey: "phone")
        NetworkHelper.shared.avatar = nil
        UserDefaults.standard.removeObject(forKey: "avatar")
        NetworkHelper.shared.selectedMovieID = nil
        UserDefaults.standard.removeObject(forKey: "selectedMovieID")
    }
    
    
    
    
}
