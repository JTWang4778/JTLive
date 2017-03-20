//
//  LiveModel.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit

class LiveModel: NSObject {
    
    var name: String? // 直播名字
    var city: String? // 直播城市
    var share_addr: String? // 直播分享地址
    var stream_addr: String? // 直播流播放地址
    var online_users: Int? // 在线观看人数
    var creator: [String: Any]? {
        didSet{
            if let creater = creator {
                liver = liveCreaterModel.init(dict: creater)
            }else {
                return;
            }
        }
    }
    
    var liver: liveCreaterModel!
    
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "online_users" {
            self.online_users = value as? Int
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

}
