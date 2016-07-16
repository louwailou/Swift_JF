//
//  JFFunction.swift
//  ProSwift
//
//  Created by Sun on 15/11/12.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class JFFunction: NSObject {
    func minMax (array:[Int])->(min:Int,max:Int){
        var currentMin = array[0];
        var currentMax = array[0];
        for value in array[1 ... array.count]{
            if value < currentMin{
                currentMin = value;
            }else if value > currentMax{
                currentMax = value;
            }
        }
    
        return (currentMin,currentMax);
    }
    /*
     以上方法 传递的参数如果是空数组，则会发生错误，所以可以修改 一下返回一个nil 的tuple 所以 在返回的tuple 后面加一个 ？
    func minMax (array:[Int])->(min:Int,max:Int)？{
        if array.isEmpty {  return nil }
    */
    
    func externalFunctionPara(externalParamname eName:String){
        
        /* 提供一个外部参数名称,方便接口使用者的使用 */
    }
    
    // 隐藏外部名称 _
    func ommitPara(paras : String ,_ pssd : String){
        
    }
}