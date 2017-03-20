//
//  LivePlayerController.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/18.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit
import IJKMediaFramework

class LivePlayerController: BaseViewController {

    var player : IJKFFMoviePlayerController!
    var liveModel: LiveModel!
    var controlView: LivePlayerControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpPlayer()
    }

    func setUpUI() {
        // 创建playerControl界面
        controlView = LivePlayerControlView.playerControlView()
        controlView.frame = self.view.bounds
        controlView.delegate = self
        controlView.backgroundColor = UIColor.clear
        self.view.addSubview(controlView)
        
        
        let playerCardView = PlayerCardView.init(frame: CGRect(x: 30, y: 30, width: 120, height: 30))
        playerCardView.liverModel = self.liveModel
        playerCardView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        self.view.addSubview(playerCardView)
        
    }
    
    func setUpPlayer() {
        // 创建播放控制器
        let playerUrl = URL.init(string: self.liveModel.stream_addr!)
        self.player = IJKFFMoviePlayerController.init(contentURL: playerUrl, with: nil)
        let playerView = self.player.view!
        playerView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.addSubview(self.player.view)
        self.view.sendSubview(toBack: self.player.view)
        self.view.autoresizesSubviews = true
        self.player.scalingMode = .aspectFit
        
        self.player.shouldAutoplay = true
        
        
        // 添加监听
        addPlayObserver()
        self.player.prepareToPlay()
        self.player.play()
    }
    
    func addPlayObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadStateDidChange(noti:)), name: Notification.Name.IJKMPMoviePlayerLoadStateDidChange, object: self.player)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.mediaIsPreparedToPlayDidChange(noti:)), name: Notification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: self.player)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moviePlayBackStateDidChange(noti:)), name: Notification.Name.IJKMPMoviePlayerPlaybackStateDidChange, object: self.player)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moviePlayBackFinish(noti:)), name: Notification.Name.IJKMPMoviePlayerPlaybackDidFinish, object: self.player)
        
    }
    // 加载状态改变
    func loadStateDidChange(noti:Notification) -> Void {
        
    }
    
    // 准备播放完成
    func mediaIsPreparedToPlayDidChange(noti:Notification) -> Void {
        
    }
    // 播放状态改变
    func moviePlayBackStateDidChange(noti:Notification) -> Void
    {
        
    }
    
    // 退出播放
    func moviePlayBackFinish(noti:Notification) -> Void
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension LivePlayerController: LivePlayerControlViewDelegate
{
    func didClickClose() {
        self.player.stop()
        self.player.shutdown()
        self.player = nil
        // 移除监听
        NotificationCenter.default.removeObserver(self)
        
        self.navigationController!.popViewController(animated: true)
    }
}
