//
//  CaptureController.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit
import LFLiveKit

class CaptureController: BaseViewController {

    //MARK: - Getters and Setters
    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 申请麦克风和相机权限
        requestAccessForAudio()
        requestAccessForVideo()
        
        startLive()
        // Do any additional setup after loading the view.
    }
    func requestAccessForVideo() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo);
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if(granted){
                    DispatchQueue.main.async {
                        self.session.running = true
                    }
                }
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.authorized:
            session.running = true;
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
    func requestAccessForAudio() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType:AVMediaTypeAudio)
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.authorized:
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }


    
    //MARK: - Event
    func startLive() -> Void {
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://live.hkstv.hk.lxdns.com:1935/live/stream153";
        session.startLive(stream)
    }
    
    func stopLive() -> Void {
        session.stopLive()
    }
    
//    //MARK: - Callback
//    func liveSession(session: LFLiveSession?, debugInfo: LFLiveDebug?){
//        
//    }
//    func liveSession(session: LFLiveSession?, errorCode: LFLiveSocketErrorCode){
//        
//    }
//    func liveSession(session: LFLiveSession?, liveStateDidChange state: LFLiveState){
//        
//    }
}

extension CaptureController: LFLiveSessionDelegate
{
    
}
