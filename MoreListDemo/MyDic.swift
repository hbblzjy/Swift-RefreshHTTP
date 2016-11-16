//
//  MyDic.swift
//  MoreListDemo
//
//  Created by healthmanage on 16/11/11.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import UIKit

class MyDic: NSObject {
    var petNameStr:String!;
    var genderIdStr:String!;
    var birthdayStr:String!;
    
    init(dict:[String:AnyObject]) {
        super.init();
        self.petNameStr = dict["petName"] as! String!;
        self.genderIdStr = dict["genderId"] as! String!;
        self.birthdayStr = dict["birthday"] as! String!;
    }
}
