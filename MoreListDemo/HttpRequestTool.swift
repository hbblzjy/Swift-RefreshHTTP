//
//  HttpRequestTool.swift
//  MoreListDemo
//
//  Created by healthmanage on 16/11/15.
//  Copyright © 2016年 healthmanager. All rights reserved.
//封装AFNetworking中GET和POST请求方法

import Foundation
import UIKit
import AFNetworking
import SVProgressHUD

//请求方式枚举
enum MethodTypes:String{
    case GET = "GET";
    case POST = "POST"
}
class HttpRequestTool: AFHTTPSessionManager {
    //静态全局
    static let httpTools:HttpRequestTool = {
        let tools = HttpRequestTool();
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain");
        return tools;
    }()
    
    //创建请求成功和失败的闭包结构
    typealias SuccessClosure = (_ responseObj:Any?)->();
    typealias FailureClosure = (_ errorObj:Error)->();
    
    //创建请求数据的工具方法
    //参数说明:mType：方式   URLString：url   parametersDic：参数   success:成功闭包结构   failure:失败闭包结构
    func urlRequestTool(mType:MethodTypes,URLString:String,parametersDic:Dictionary<String,Any>?,successComplete: @escaping SuccessClosure,failureComplete:@escaping FailureClosure) {
        SVProgressHUD.show(withStatus: "正在加载");
        if mType == .GET {
            self.get(URLString, parameters: parametersDic, progress: nil, success: { (_, respData) -> Void in
                //返回数据
                SVProgressHUD.dismiss(withDelay: 1);
                successComplete(respData);
            }, failure: { (_, err) in
                //返回错误
                SVProgressHUD.dismiss(withDelay: 1);
                failureComplete(err);
            })
        }else{
            self.post(URLString, parameters: parametersDic, progress: nil, success: { (_, respData) in
                //返回数据
                SVProgressHUD.dismiss(withDelay: 1);
                successComplete(respData);
            }, failure: { (_, err) in
                //返回错误
                SVProgressHUD.dismiss(withDelay: 1);
                failureComplete(err);
            })
        }
    }
}

