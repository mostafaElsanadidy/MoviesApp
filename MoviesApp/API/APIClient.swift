//
//  ApiClient.swift
//  MadeInKuwait
//
//  Created by Amir on 1/29/20.
//  Copyright © 2020 Amir. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIClient {
    
    @discardableResult
    private static func performSwiftyRequest(route:APIRouter,_ completion:@escaping (JSON)->Void,_ failure:@escaping (Error?)->Void) -> DataRequest {
        return Alamofire.request(route)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success :
                    guard let _ = response.result.value else {
                        failure(response.result.error)
                        return
                    }
                    print(response.result , route.urlRequest as Any)
                    let json = JSON(response.result.value as Any)
                    print(json)
                    //                    if !(response.response?.statusCode == 200) {
                    //                        failure(response.result.error)
                    //                        return
                    //                    }
                    completion(json)
                    //
                    //                    if let status_code = json["status"].string {
                    //                        print(status_code)
                    //                        if status_code == "402"   { // TOKEN EXPIRE
                    //                            //API.REFRESH reSaveToken
                    //                            performSwiftyRequest(route: route, completion, failure)
                    //                        }else {
                    //                            completion(json)
                    //                        }
                    //                    }else {
                    //                        failure(response.result.error)
                    //                        completion(json)
                    //                    }
                //
                case .failure( _):
                    failure(response.result.error)
                }
            })
    }
    
    
    static func cancelAllRequests(completed : @escaping ()->() ) {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
            completed()
        }
    }
    
    static func login(username:String, pass:String , completionHandler:@escaping (User_M?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
         performSwiftyRequest(route: .login(username: username, password: pass), { (jsonData) in
             let json = JSON(jsonData)
             let user = User_M(fromJson: json)
             completionHandler(user)
         }) { (error) in
             completionFaliure(error)
         }
     }
    
    static func register(username:String, pass:String ,name:String , phone:String , completionHandler:@escaping (User_M?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .register(username: username, password: pass, name: name, phone: phone), { (jsonData) in
            let json = JSON(jsonData)
            let user = User_M(fromJson: json)
            completionHandler(user)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func user_orders(userid:Int , completionHandler:@escaping ([UserOrders_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .user_orders(userid: userid), { (jsonData) in
            let json = JSON(jsonData)
            var list_ = [UserOrders_M]()
            for list_Json in json.arrayValue{
                let value = UserOrders_M(fromJson: list_Json)
                list_.append(value)
            }
            completionHandler(list_)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func sub_vendor(vencat:String , completionHandler:@escaping ([SubVendor_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
          performSwiftyRequest(route: .vendor_list(vencat: vencat), { (jsonData) in
              let json = JSON(jsonData)
              var list_ = [SubVendor_M]()
              for list_Json in json.arrayValue{
                  let value = SubVendor_M(fromJson: list_Json)
                  list_.append(value)
              }
              completionHandler(list_)
          }) { (error) in
              completionFaliure(error)
          }
    }
    
    static func vendor_details(venid:Int , completionHandler:@escaping (VendorDetails_M?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .vendor_details(venid: venid), { (jsonData) in
            let json = JSON(jsonData)
            let user = VendorDetails_M(fromJson: json)
            
            completionHandler(user)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func create_order(venid:Int , des:String , from_Add:String ,to_Add:String , customerID:Int , image:String , voice:String ,completionHandler:@escaping (String?,String?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .create_order(vendorID: venid, des: des, from_address: from_Add, to_address: to_Add, customerID: customerID, image: image , voice: voice), { (jsonData) in
            let json = JSON(jsonData)
            let status = json["status"].stringValue
            let msg = json["message"].stringValue

            completionHandler(status , msg)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func edit_profile(id:Int, name:String, email:String, phone:String , completionHandler:@escaping (String? , String?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .editProfile(id: id, name: name, email: email, phone: phone), { (jsonData) in
            let json = JSON(jsonData)
            let status = json["status"].stringValue
            let message = json["message"].stringValue

            completionHandler(status , message)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func edit_avatar(id:Int, avatar:String, completionHandler:@escaping (String? , String?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route:.edit_avatar(id: id, avatar: avatar), { (jsonData) in
            let json = JSON(jsonData)
            let status = json["status"].stringValue
            let message = json["message"].stringValue

            completionHandler(status , message)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    
    static func add_address(id:Int, title:String, address:String, completionHandler:@escaping (String? , String?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route:.add_address(id: id, title: title, address: address), { (jsonData) in
            let json = JSON(jsonData)
            let status = json["status"].stringValue
            let message = json["message"].stringValue

            completionHandler(status , message)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    
    static func submitOrder(json: Parameters, completionHandler:@escaping (String?,String?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .submitCartOrder(json: json), { (jsonData) in
            let json = JSON(jsonData)
            let status = json["status"].stringValue
            let msg = json["message"].stringValue
            completionHandler(status,msg)
        }) { (error) in
            completionFaliure(error)
        }
    }
    
}
