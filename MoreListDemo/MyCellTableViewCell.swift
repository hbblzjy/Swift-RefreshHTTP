//
//  MyCellTableViewCell.swift
//  MoreListDemo
//
//  Created by healthmanage on 16/11/11.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {
    
    var dataDic = NSDictionary();
    
    var headImgView = UIImageView();
    var nameLabel = UILabel();
    var birthDayLabel = UILabel();
    var sexImgView = UIImageView();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //头像
        headImgView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 60, height: 60));
        headImgView.layer.cornerRadius = 30;
        //headImgView.layer.borderColor = RGBA(R: 80, G: 90, B: 70, A: 1).cgColor;
        headImgView.layer.borderColor = colorWithHexString(hex: "#01c675").cgColor;
        headImgView.layer.borderWidth = 2;
        self.addSubview(headImgView);
        //姓名
        nameLabel = UILabel.init(frame: CGRect.init(x: 75, y: 10, width: 150, height: 30));
        nameLabel.font = UIFont.systemFont(ofSize: 15);
        nameLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(nameLabel);
        //生日
        birthDayLabel = UILabel.init(frame: CGRect.init(x: 75, y: 40, width: 150, height: 30));
        birthDayLabel.font = UIFont.systemFont(ofSize: 13);
        birthDayLabel.textColor = UIColor.lightGray;
        birthDayLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(birthDayLabel);
        //性别
        sexImgView = UIImageView.init(frame: CGRect.init(x: 225, y: 15, width: 25, height: 25))
        self.addSubview(sexImgView);
    }
    //自定义方法
    func setDataDic(dataDic:NSDictionary)
    {
        self.dataDic = dataDic;
        
        self.nameLabel.text = self.dataDic["petName"] as? String;
        let sexStr = self.dataDic["genderId"] as? String;//也可以转成NSString使用
        //NSString 有一个方法isEqualToString 方法用来判断两个字符串是否完全相等，String没有这个方法，但是因为String是值类型所以可以直接用 == 判断是否完全相等。
        if sexStr == "1" {
            self.sexImgView.image = UIImage.init(named: "baby_sex_boy");
            self.headImgView.image = UIImage.init(named: "baby_default_boy");
        }
        else
        {
            self.sexImgView.image = UIImage.init(named: "baby_sex_girl");
            self.headImgView.image = UIImage.init(named: "baby_default_girl");
        }
        
        self.birthDayLabel.text = NSString.init(format: "生日：%@",(self.dataDic["birthday"] as? String)!) as String;
    }
    
    //Model方法
    func setMyDicModel(dataModel:MyDic)
    {
        self.nameLabel.text = dataModel.petNameStr;
        let sexStr = dataModel.genderIdStr;//也可以转成NSString使用
        //NSString 有一个方法isEqualToString 方法用来判断两个字符串是否完全相等，String没有这个方法，但是因为String是值类型所以可以直接用 == 判断是否完全相等。
        if sexStr == "1" {
            self.sexImgView.image = UIImage.init(named: "baby_sex_boy");
            self.headImgView.image = UIImage.init(named: "baby_default_boy");
        }
        else
        {
            self.sexImgView.image = UIImage.init(named: "baby_sex_girl");
            self.headImgView.image = UIImage.init(named: "baby_default_girl");
        }
        
        self.birthDayLabel.text = NSString.init(format: "生日：%@",dataModel.birthdayStr) as String;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
