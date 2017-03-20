//
//  LiveListControllerViewController.swift
//  MuXueLive
//
//  Created by 王锦涛 on 2016/12/17.
//  Copyright © 2016年 JTWang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import SVProgressHUD

class LiveListControllerViewController: BaseViewController {

    var tableView: UITableView!
    var modelArr = NSMutableArray()
    let cellReuseID = "live_list_cell"
    
    var isScrollUp: Bool = false
    
    var lastContentOffetY: CGFloat = -64.0
    
    // 刷新相关
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        loadDataWithAlamofire()
//        loadData()
        
        // 网络请求工具测试
        loadDataWithNetworkToolTest()
        
    }
    
    func loadDataWithNetworkToolTest() {
        
        // 第一种调用方式
//        NetworkHelper.requestGETWith(urlStr: "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1", params: nil, success:{
//            (resultObject) in
//            
//            print(resultObject)
//            if let error_code = resultObject["dm_error"] as? Int{
//                if error_code == 0 {
//                    // 请求成功
//                    if let dictArr = resultObject["lives"] as? [[String: Any]]{
//                        
//                        for dict in dictArr{
//                            let model = LiveModel.init(dict: dict)
//                            self.modelArr.add(model)
//                        }
//                        self.tableView.reloadData()
//                    }
//
//                }else {
//                    // 请求失败
//                    print("请求出错%@",resultObject["error_msg"] as! String)
//                }
//            }
//            
//            
//        }, failture: {
//            (error) in
//            print("请求失败%@",error)
//        })
        
        // 第二种调用方式 使用尾随闭包
        NetworkHelper.requestGETWithoutAlamofire(urlStr: "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1", params: nil, success: {
            (resultObject) in
            
            // 1,手动解析数据
//            print(resultObject)
//            if let dictArr = resultObject["lives"] as? [[String: Any]]{
//                
//                for dict in dictArr{
//                    let model = LiveModel.init(dict: dict)
//                    self.modelArr.add(model)
//                }
//                
//                self.tableView.reloadData()
//            }

            //  2,使用swiftlyJson 解析数据
            let json = JSON(resultObject)
            let error_code = json["dm_error"].intValue
            
            if error_code == 0{
                // 返回成功
//                SVProgressHUD.showProgress(0.6)
                SVProgressHUD.showSuccess(withStatus: "显示成功")
//                SVProgressHUD.showError(withStatus: "请求失败")
//                SVProgressHUD.showInfo(withStatus: "显示信息")
//                SVProgressHUD.show(withStatus: "请求成功")
//                SVProgressHUD.show(nil, status: "请求成功")
//                SVProgressHUD.show()
                let dictArr = json["lives"]
                for dict in dictArr{
                    
                    let dd = dict.1.dictionaryObject!
                    let model = LiveModel.init(dict: dd)
                    if self.modelArr.count > 10 {
                        break;
                    }
                    self.modelArr.add(model)
                }
                // 回主线程刷新ui  不然会慢很多
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.tableView.mj_header.endRefreshing()
                })
//                self.tableView.reloadData()

                
                

            }else{
                // 返回失败
                
            }
            
            
            
            
            
        }){(error) in
            // 尾随闭包的形式
            print(error)
        }
        
    }
    
    func loadDataWithAlamofire() {
        let urlStr = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
        Alamofire.request(urlStr).validate().responseJSON(completionHandler:{
            (response) -> Void in
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms:\(response.result.error)")
                // guard 只有当条件不成立的时候 才会执行后面的方法  否则不成立  经常用于处理错误
                return
            }
        
            // 请求成功 解析数
            print(response.result.value!)
            
            if let resultDict = response.result.value! as? [String : Any]{
                print(resultDict)
                
                // "error_msg": 操作成功, "dm_error": 0,
                if let dm_error = (resultDict["dm_error"] as? Int){
                    if dm_error == 0 {
                        // 请求成功
                        print("请求成功")
                        
                        if let dictArr = resultDict["lives"] as? [[String: Any]]{
                            
                            for dict in dictArr{
                                let model = LiveModel.init(dict: dict)
                                self.modelArr.add(model)
                            }
                            
                            
                            self.tableView.reloadData()
                        }
                        
                    }else{
                        // 请求出错  取出错误信息
                        print("请求出错%@",resultDict["error_msg"] as! String)
                    }
                }
            }else{
                print("解析失败")
            }
        
    })
        
    }
    func loadData() {
        
        // 1，纯手工请求解析网络数据
        let urlStr = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
        let url = URL.init(string: urlStr)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data , response, errorr) in
            if errorr != nil {
                print(errorr!)
            }else{
                
                let jsonObject:[String: AnyObject] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                let dm_error = jsonObject["dm_error"] as! Int
                if dm_error != 0 {
                    let error_msg = jsonObject["error_msg"] as! String
                    print(error_msg)
                }
                
                // 解析数据
                let dictArr = jsonObject["lives"] as! [[String: Any]]
                for dict in dictArr{
                    let model = LiveModel.init(dict: dict)
                    
                    self.modelArr.add(model)
                }
                
                self.tableView.reloadData()
                
            }
            
            
        })
        dataTask.resume()
        
    }
    func setupUI() {
        self.edgesForExtendedLayout = .all
        self.automaticallyAdjustsScrollViewInsets = true
        tableView = UITableView.init(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.randomColor()
        tableView.setY(y: 0)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 66
        
        // 刷新相关
        header.setRefreshingTarget(self, refreshingAction: #selector(self.refreshData))
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.loadMoreData))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer = footer
        
        let nib = UINib.init(nibName: "LiveListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellReuseID)
        self.view.addSubview(tableView)

    }
    
    func refreshData() {
        // 刷新数据
        self.loadDataWithNetworkToolTest()
        
    }
    
    func loadMoreData() {
        
        print("加载更多数据")
        // 数据请求成功后 结束刷新
        self.tableView.mj_footer.endRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension LiveListControllerViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! LiveListCell
        let model = self.modelArr[indexPath.row] as! LiveModel
        cell.liveModel = model
        cell.clickBlock = {
            (model) in
            let cardView = LiverCardView.liveCardView()
            cardView.liverModel = model.liver
            cardView.frame = CGRect(x: 0, y: 0, width: 200, height: 300);
            cardView.layer.cornerRadius = 10
            cardView.layer.masksToBounds = true
            cardView.center = self.view.center
            self.view.addSubview(cardView)
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 + UIScreen.main.bounds.width
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.removeAllAnimations()
        cell.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: { (_) in
//            let anim = CATransition()
//            anim.type = "rippleEffect"
//            anim.duration = 1
//            cell.layer.add(anim, forKey: "11")
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArr[indexPath.row] as! LiveModel
        
        let palyerControler = LivePlayerController()
        palyerControler.liveModel = model
        palyerControler.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(palyerControler, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let sub = scrollView.contentOffset.y - lastContentOffetY
        if  sub > 0 {
            isScrollUp = true
        }else{
            isScrollUp = false
        }
        lastContentOffetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        if  velocity.y > 0.0 {
            isScrollUp = true
        }else if velocity.y < 0.0 {
            isScrollUp = false
        }
        beginAnim()
    }
    
    fileprivate func beginAnim() {
        if isScrollUp {
            showTopViewAnim()
        }else {
            
            hiddenTopViewAnim()
        }
    }
    
    fileprivate func hiddenTopViewAnim() {
        UIView.animate(withDuration: 2.5, animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: { (_) in
//            self.tableView.mj_header.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        })
    }
    
    fileprivate func showTopViewAnim() {
        UIView.animate(withDuration: 2.5, animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: { (_) in
            self.tabBarController?.tabBar.isHidden = true
//            self.tableView.mj_header.isHidden = false
        })
    }


}
