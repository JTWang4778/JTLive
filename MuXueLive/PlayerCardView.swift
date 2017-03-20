//
//  PlayerCardView.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2017/1/10.
//  Copyright © 2017年 JTWang. All rights reserved.
//

import UIKit
import SnapKit

class PlayerCardView: UIView {

    var iconImageView = UIImageView()
    var liveLabel = UILabel()
    var onlineLabel = UILabel()
    var followButton = UIButton()
    
    var liverModel: LiveModel!{
        didSet{
            var iconImageUrlStr = liverModel.liver.portrait!
            if iconImageUrlStr.hasPrefix("http://img2.inke.cn/") == false {
                iconImageUrlStr = "http://img2.inke.cn/" + iconImageUrlStr
            }
            
            
            let imageUrl = URL.init(string: iconImageUrlStr)!
            self.iconImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: "avatar_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
            onlineLabel.text = "\(liverModel.online_users!)"
            
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
    
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        
        liveLabel.font = UIFont.systemFont(ofSize: 12)
        liveLabel.text = "直播"
        liveLabel.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        self.addSubview(liveLabel)
        
        liveLabel.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            make.left.equalTo(iconImageView.snp.right).offset(6)
            make.top.equalTo(self.snp.top).offset(0)
            
        }
        
        
        onlineLabel.font = UIFont.systemFont(ofSize: 12)
        onlineLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.addSubview(onlineLabel)
        onlineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(6)
            make.bottom.equalTo(self)
        }
        
        
        
        followButton.setTitle("关注", for: .normal)
        followButton.setTitle("关注", for: .highlighted)
        followButton.setTitleColor(UIColor.black, for: .normal)
        followButton.backgroundColor = #colorLiteral(red: 0.3525206851, green: 0.8549019694, blue: 0.8300044773, alpha: 1)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        followButton.layer.cornerRadius = 12
        followButton.layer.masksToBounds = true
        followButton.addTarget(self, action: #selector(self.didClickFollowButton), for: .touchUpInside)
        self.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-6)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        
    }
    
    func didClickFollowButton() {
        print("关注")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
