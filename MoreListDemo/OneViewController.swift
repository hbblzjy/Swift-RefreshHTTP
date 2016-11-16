//
//  OneViewController.swift
//  MoreListDemo
//
//  Created by healthmanage on 16/11/15.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import AFNetworking
import SVProgressHUD

class OneViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var myTableView = UITableView();
    var dataArray = NSMutableArray();
    var pageIndexI = NSInteger();
    
    override func viewWillAppear(_ animated: Bool) {
        self.pageIndexI = 1;
        self.dataHttpRequest(pageIndexStr: NSString.init(format: "%d", self.pageIndexI));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white;
        self.title = "One页面"
        
        dataArray = NSMutableArray.init()
        
        self.myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H), style: UITableViewStyle.plain);
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.rowHeight = 80;
        self.myTableView.tableHeaderView = UIView.init();
        self.myTableView.tableFooterView = UIView.init();
        self.view.addSubview(self.myTableView);
        //注册Cell
        self.myTableView.register(MyCellTableViewCell.self, forCellReuseIdentifier: "myCell");
        // Nib 注册
        //self.tableView.registerNib(UINib(nibName: "MyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        //添加下拉刷新
        self.myTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            //数据加载
            self.pageIndexI = 1;
            self.dataHttpRequest(pageIndexStr: NSString.init(format: "%d", self.pageIndexI));
        });
    }
    //MARK:------------- UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyCellTableViewCell;
        
        //cell.setDataDic(dataDic: dataArray[indexPath.row] as! NSDictionary);
        cell.setMyDicModel(dataModel: dataArray[indexPath.row] as! MyDic);
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        return cell;
    }
    
    //MARK：-------AFNetworking基本的数据请求形式（未封装的方法）
    func dataHttpRequest(pageIndexStr:NSString) {
        
        //SVProgressHUD.show(withStatus: "正在加载");
        if pageIndexStr.isEqual(to: "1") {
            self.pageIndexI = 1;
            self.dataArray.removeAllObjects();
        }
        
        let urlStr = "http://www.healthmanage.cn/android/hrsBabyAction_loadHrsBabyHealth.action";
        let paramsDic = ["userId":"38567","pagesize":"6","pageIndex":pageIndexStr];
        
        //使用封装的方法进行POST请求
        HttpRequestTool.httpTools.urlRequestTool(mType: MethodTypes.POST, URLString: urlStr, parametersDic: paramsDic, successComplete: {(responseData) in
            
            print("输出此时的数据请求结果......\(responseData)");
            
            //SVProgressHUD.dismiss(withDelay: 1);
            self.myTableView.mj_header.endRefreshing();
            //守卫语句，用于判断不符合条件时安全退出，而不是crash
            guard (responseData as? NSDictionary) != nil else{
                print("返回数据为nil，或者 类型不匹配");
                return;
            };
            let resultDic = responseData as! NSDictionary;
            let successB = resultDic["success"] as! Bool;
            if(successB){
                //如果返回有值
                let itemArray = resultDic["ITEMS"] as! NSArray;
                
                if(self.myTableView.mj_footer != nil)
                {
                    self.myTableView.mj_footer.endRefreshing();
                }
                else
                {
                    //判断数组数量和page，如果符合条件就添加上拉加载
                    if(itemArray.count == 6 && pageIndexStr.isEqual(to: "1"))
                    {
                        self.myTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock:{ () -> Void in
                            
                            self.pageIndexI = self.pageIndexI+1;
                            self.dataHttpRequest(pageIndexStr: NSString.init(format: "%d", self.pageIndexI));
                        })
                    }
                }
                
                for dic in itemArray {
                    //因为数组中是:[String:AnyObject]字典类型，所以不能使用as！NSDictionary,我是这么理解的，不知道对不对
                    let itemModel = MyDic.init(dict: dic as! [String : AnyObject]);
                    self.dataArray.add(itemModel);
                }
                self.myTableView.reloadData();
            }
            else
            {
                //print(".......................");
                //请求无数据NOVALUE情况
                if self.dataArray.count>0{
                    self.myTableView.mj_footer.endRefreshing();
                    self.myTableView.mj_footer = nil;
                }
            }
        }, failureComplete: {(error) in
            print("请求数据错误报告...........\(error)");
            SVProgressHUD.showError(withStatus: "网络请求错误");
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
