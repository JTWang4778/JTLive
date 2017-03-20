//
//  NetworkHelper.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit
import Alamofire

class NetworkHelper: NSObject {
    
    
    
    static func requestPOSTWith(urlStr:String, params:[String:AnyObject],success:@escaping (_ responseObject:[String: AnyObject]) -> (),failture:@escaping (_ error: Error) -> ()) {
        
        
        Alamofire.request(urlStr, method: HTTPMethod.post, parameters: params, encoding:JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            if response.result.isSuccess{
                // 请求成功
                if let value = response.result.value as? [String : AnyObject] {
                    success(value)
                }
            }else{
                // 请求失败
                failture(response.result.error!)
            }
        }
        
    }
    
    
    static func requestGETWith(urlStr:String, params:[String:AnyObject]?,success:@escaping (_ responseObject:[String: AnyObject]) -> (),failture:@escaping (_ error: Error) -> ()) {
        
        Alamofire.request(urlStr, method: HTTPMethod.get, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            
            if response.result.isSuccess{
                // 请求成功
                if let value = response.result.value! as? [String : AnyObject] {
                    success(value)
                }
            }else{
                // 请求失败
                failture(response.result.error!)
            }
            
        }
        
    }
    
    
    static func requestGETWithoutAlamofire(urlStr:String, params:[String:AnyObject]?,success:@escaping (_ responseObject:[String: AnyObject]) -> (),failture:@escaping (_ error: Error) -> ()) {
    
        let url = URL.init(string: urlStr)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data , response, errorr) in
            if errorr != nil {
                failture(errorr!)
            }else{
                
                let jsonObject:[String: AnyObject] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                success(jsonObject)
                
            }
            
            
        })
        dataTask.resume()
    }


}
