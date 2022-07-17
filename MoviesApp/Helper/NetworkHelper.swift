//
//  NetworkHelper.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 3/14/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    //MARK: - singleton
    static let shared = NetworkHelper()
    //MARK: - SAVE USER DATA
//    var movieName:String?{
//        set{self.movieName = newValue}
//        get{return self.movieName}
//    }
    
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
    }
    
    
    
    
}
