//
//  LivePlayerControlView.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/18.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit

protocol LivePlayerControlViewDelegate {
    func didClickClose()
}

class LivePlayerControlView: UIView {
    
    var delegate: LivePlayerControlViewDelegate?

    static func playerControlView() -> LivePlayerControlView{
        let asdf = Bundle.main.loadNibNamed("LivePlayerControlView", owner: nil, options: nil)?.last as! LivePlayerControlView
        return asdf
    }
    
    @IBAction func didClickCloseButton(_ sender: Any) {
        
        self.delegate?.didClickClose()
    }
    
    
}
