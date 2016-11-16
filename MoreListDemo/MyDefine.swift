//
//  MyDefine.swift
//  MoreListDemo
//
//  Created by healthmanage on 16/11/15.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import Foundation
import UIKit

//屏幕宽
let SCREEN_W = UIScreen.main.bounds.width
//屏幕高
let SCREEN_H = UIScreen.main.bounds.height
//导航栏高度
let Nav_H:CGFloat = 64
//切换栏高度
let TabBar_H:CGFloat = 49
//系统版本
let iOS_VERSION = (UIDevice.current.systemVersion as NSString).doubleValue
//颜色设置方式一：
func RGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat)->UIColor{
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha:A)
}
//颜色设置方式二：
func colorWithHexString(hex:String) ->UIColor {
    var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased();
    
    if (cString.hasPrefix("#")) {
        let index = cString.index(cString.startIndex, offsetBy:1);
        cString = cString.substring(from: index);
    }
    if (cString.characters.count != 6) {
        return UIColor.red;
    }
    let rIndex = cString.index(cString.startIndex, offsetBy: 2);
    let rString = cString.substring(to: rIndex);
    let otherString = cString.substring(from: rIndex);
    let gIndex = otherString.index(otherString.startIndex, offsetBy: 2);
    let gString = otherString.substring(to: gIndex);
    let bIndex = cString.index(cString.endIndex, offsetBy: -2);
    let bString = cString.substring(from: bIndex);
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r);
    Scanner(string: gString).scanHexInt32(&g);
    Scanner(string: bString).scanHexInt32(&b);
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1));
}
//输出语句
func NSLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        print("\(methodName)[\(lineNumber)]:\(message)");
    #endif
}


