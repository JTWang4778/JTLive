//
//  LiveListCell.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit
import Kingfisher

class LiveListCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var onlineLabel: UILabel!
    
    
    @IBOutlet weak var liveImageView: UIImageView!
    
    
    var clickBlock:((_ liverModel: LiveModel) -> ())?
    
    
    var liveModel: LiveModel! {
        didSet{
            self.nameLabel.text = liveModel.liver.nick!
            self.cityLabel.text = liveModel.city!
            let online = liveModel.online_users!
            self.onlineLabel.text = "\(online)人在看"
            
            var iconImageUrlStr = liveModel.liver.portrait!
            if iconImageUrlStr.hasPrefix("http://img2.inke.cn/") == false {
                iconImageUrlStr = "http://img2.inke.cn/" + iconImageUrlStr
            }
            
            
            let iconUrl = URL.init(string: iconImageUrlStr)!
            self.liveImageView.kf.setImage(with: iconUrl, placeholder: UIImage.init(named: "avatar_default"), options: nil, progressBlock: nil, completionHandler: nil)
            self.iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage.init(named: "avatar_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconImageView.layer.cornerRadius = 25
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didClickIconimageView))
        self.iconImageView.addGestureRecognizer(tap)
    }
    
    func didClickIconimageView() {
        // 拿到用户模型 展示上去
        self.clickBlock!(self.liveModel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
