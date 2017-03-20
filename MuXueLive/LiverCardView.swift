//
//  LiverCardView.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2017/1/8.
//  Copyright © 2017年 JTWang. All rights reserved.
//

import UIKit

class LiverCardView: UIView {
    
    
    var liverModel : liveCreaterModel!{
        didSet{
            
            var iconImageUrlStr = liverModel.portrait!
            if iconImageUrlStr.hasPrefix("http://img2.inke.cn/") == false {
                iconImageUrlStr = "http://img2.inke.cn/" + iconImageUrlStr
            }
            let iconUrl = URL.init(string: iconImageUrlStr)!
            
            self.gigIconImageView.kf.setImage(with: iconUrl, placeholder: UIImage.init(named: "avatar_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    @IBOutlet weak var gigIconImageView: UIImageView!
    
    
    
    
    @IBAction func didClickClose(_ sender: Any) {
        
        self.removeFromSuperview()
    }

    static func liveCardView() -> LiverCardView{
        
        let asdf = Bundle.main.loadNibNamed("LiverCardView", owner: nil, options: nil)?.last as! LiverCardView
        return asdf
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.gigIconImageView.layer.cornerRadius = 75
        self.gigIconImageView.layer.masksToBounds = true
    }

}
