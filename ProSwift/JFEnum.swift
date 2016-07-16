//
//  JFEnum.swift
//  ProSwift
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}


// 设置关联值
enum mobileLanguageFun{
    case IOS (String, String)
    case Android (String)
    //定义枚举函数
    var description: String{
        switch self {
        case  mobileLanguageFun.IOS(let language1, let language2):
            return "language1 = \(language1), language2 = \(language2)"
            
        case mobileLanguageFun.Android(let temp):
            return temp
            
        default:
            return ("NO")
        }
        
    }
}

//  var myMobile: mobileLanguageFun = mobileLanguageFun.IOS("objc", "swift")


//给枚举赋值
enum City: String{
    case Beijing = "北京"
    case ShangHai = "上海"
    case GuangZhou = "广州"
    case ShengZhen = "深圳"
}
//var youInCity: City? = City(rawValue: "北京");
// 通过枚举成员的值 来初始化枚举成员，如果存在则成功，不存在 失败 nil