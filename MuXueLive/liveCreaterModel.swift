//
//  liveCreaterModel.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit

class liveCreaterModel: NSObject {
    /*
     "id":245687180,
     "level":4,
     "gender":0,
     "nick":"CRI日语频道",
     "portrait":"http://img2.inke.cn/MTQ4MTUyNTgxOTc5MSMzMjMjanBn.jpg"
     */
    
    var id: Int!
    var level: Int?
    var gender: Int?
    var nick: String?
    var portrait: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
